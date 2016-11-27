
require_relative '../../../probes/ruby_probe.rb'

if ARGV.empty?
  scythe_probe("program_path")
  scythe_probe "paran_less"
else
  scythe_probe("non_program_path")
  scythe_probe "paran_less2"
end


