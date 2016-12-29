

require 'functions'
require 'probe'

class GatherCommand

  def initialize dir, out, err
    @dir = dir
    @out = out
    @err = err
  end

  def run
    unless probe_env_var && File.directory?(probe_env_var)
      @err.puts "scythe: environment variable SCYTHE_PROBE_DIR not set"
      exit(1)
    end


    unless @dir && File.directory?(@dir) 
      @err.puts "scythe: -g option requires a valid directory argument"
      exit(1)
    end

    project_dir = File.expand_path(@dir) 

    probe_markers =
      file_names(project_dir).grep(/\.rb$|\.py$|\.java$/)
                             .flat_map {|fn| markers(fn) }
    
    duplicated_markers =
      probe_markers.group_by {|m| m }
                   .select {|_,ms| ms.count >= 2 }
                   .keys

    unless duplicated_markers.empty?
      @err.puts "scythe: the following probes found more than once in #{project_dir}:\n"
      @err.puts "\n#{duplicated_markers.join($/)}\n\n" 
      exit(1)
    end

    removed_markers = get_probes(probe_dir).map(&:name) - probe_markers.uniq

    unless removed_markers.empty?
      @err.puts "scythe: the following probes were not found in #{project_dir}"
      @err.puts "  Consider deleting them with -d:"
      @err.puts "\n#{removed_markers.join($/)}\n\n"
    end

    probe_markers.uniq.each do |marker|
      record_probe(marker)
    end
  end
  
end
