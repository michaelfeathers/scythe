
require 'functions'
require 'probe'

class DeleteCommand
  def initialize probe_name, out, err
    @probe_name = probe_name
    @out = out
    @err = err
  end

  def run
    unless probe_env_var && File.directory?(probe_env_var)
      @err.puts "scythe: environment variable SCYTHE_PROBE_DIR not set"
      exit(1)
    end

    probes = get_probes(probe_dir) 
    puts probes.map(&:name)

    if probes.map(&:name).select {|n| n == @probe_name }.empty?
      @err.puts "scythe: unable to find probe #{@probe_name}"
      exit(1)
    end

    delete_probe(@probe_name)
  end

end
