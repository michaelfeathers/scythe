
$:.unshift File.dirname(__FILE__)

require 'find'

RUBY_MARKER_PATTERN = /scythe_probe\s*\(\s*\"(\w+)\"\s*\)/
PROBE_EXT_PATTERN = /\.scythe_probe$/
PROBE_EXT = ".scythe_probe"


def probe_env_var
  ENV["SCYTHE_PROBE_DIR"]
end

def probe_dir
  File.expand_path(probe_env_var)
end

def file_names file_spec
  Find.find(File.expand_path(file_spec))
end

def markers fn
  IO.read(fn).scan(RUBY_MARKER_PATTERN).flatten
rescue
  []
end

def make_file fn
  File.open(fn, "w") {|_|} 
end

def record_probe probe_name
  probe_fn = File.join(probe_dir, probe_name + PROBE_EXT) 
  make_file(probe_fn) unless File.exist?(probe_fn)
end

def get_probe file_name 
  Probe.new(File.basename(file_name, ".*"),
            File.mtime(file_name).to_i)
end

def get_probes dir
  file_names(dir).grep(PROBE_EXT_PATTERN)
                 .map {|fn| get_probe(fn) }
end

def delete_probe probe_name
  probe_fn = File.join(probe_dir, probe_name + probe_EXT) 
  File.delete(probe_fn)
end


