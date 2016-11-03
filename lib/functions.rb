
$:.unshift File.dirname(__FILE__)

require 'find'

RUBY_MARKER_PATTERN = /scythe_probe\s*\(\s*\"(\w+)\"\s*\)/
MARKER_EXT_PATTERN = /\.scythe_marker$/
MARKER_EXT = ".scythe_marker"


def marker_env_var
  ENV["SCYTHE_MARKER_DIR"]
end

def marker_dir
  File.expand_path(marker_env_var)
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

def record_marker marker_name
  marker_fn = File.join(marker_dir, marker_name + MARKER_EXT) 
  make_file(marker_fn) unless File.exist?(marker_fn)
end

def get_probe file_name 
  Probe.new(File.basename(file_name, ".*"),
            File.mtime(file_name).to_i)
end

def get_probes dir
  file_names(dir).grep(MARKER_EXT_PATTERN)
                 .map {|fn| get_probe(fn) }
end


