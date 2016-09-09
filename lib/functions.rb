

require 'find'

def files file_spec
  Find.find(File.expand_path(file_spec))
end
