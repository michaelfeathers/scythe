
$:.unshift File.dirname(__FILE__)

class RubyGatherer
  def initialize reader
    @reader = reader
  end

  def markers
    []
  end
    
end
