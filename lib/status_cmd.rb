

require 'functions'
require 'probe'

class StatusCommand
  def initialize format, out, err
    @format = format
    @out = out
    @err = err
  end

  def run
    unless probe_env_var && File.directory?(probe_env_var)
      @err.puts "scythe: environment variable SCYTHE_PROBE_DIR not set"
      exit(1)
    end

    unless ["secs", "hours", "days", ""].include?(@format)
      STDERR.puts "scythe: #{@format} is an invalid format for -s"
      exit(1)
    end


    now = Time.now.to_i

    probes = get_probes(probe_dir) 

    probes.map {|probe| [probe.name, probe.silent?(now, reporting_interval(@format))]}
          .sort_by {|name, elapsed| [-elapsed, name] }
          .each do |name, elapsed|
            puts "%-30s %6d" % [name, elapsed]
          end
    

  end
end
