

require 'fileutils'

def scythe_probe name
  last_time = ($scythe ||= {})[name] 
  $scythe[name] = Time.now.to_i

  update_period = 86400    # rough number of seconds in a day
  return unless (not last_time) || ($scythe[name] - last_time >= update_period)

  begin
    dir = ENV["SCYTHE_MARKER_DIR"] || "."
    return unless File.directory?(dir)

    fn = File.join(dir, name + ".scythe_marker")
    return unless File.exist?(fn)

    FileUtils.touch(fn)
  rescue Exception => e
    nil
  end
end
