
$:.unshift File.dirname(__FILE__)

require 'find'

RUBY_MARKER_PATTERN = /scythe_probe\s*\(\s*\"(\w+)\"\s*\)/
MARKER_DIR = File.expand_path(".") 


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
  marker_fn = File.join(marker_dir, marker_name + ".scythe_marker")
  make_file(marker_fn) unless File.exist?(marker_fn)
end


