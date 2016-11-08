

require 'fileutils'

def scythe_probe marker
  dir = File.expand_path(ENV["SCYTHE_PROBE_DIR"])
  return unless dir && File.directory?(dir)

  fn = File.join(dir, marker + ".scythe_probe")
  return unless File.exist?(fn)

  FileUtils.touch(fn)
rescue Exception => e
    nil
end
