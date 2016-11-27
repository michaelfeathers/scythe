
$:.unshift File.dirname(__FILE__)

class RubyGatherer
  def initialize reader
    @reader = reader
  end

  def markers
    @reader.read.scan(/scythe_probe\s*\(\s*\"(\w+)\"\s*\)/).flatten
  end
    
end
