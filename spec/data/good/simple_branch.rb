
require_relative '../../../probes/ruby_probe.rb'

if ARGV.empty?
  scythe_probe("program_path")
else
  scythe_probe("non_program_path")
end

