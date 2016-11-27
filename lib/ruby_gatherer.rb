
$:.unshift File.dirname(__FILE__)

class RubyGatherer
  def initialize reader
    @reader = reader
  end

  def markers
    paren_form = Regexp.new('scythe_probe\s*\(\s*\"(\w+)\"\s*\)')
    parenless_form = Regexp.new('scythe_probe\s*\"(\w+)\"')

    [paren_form, parenless_form]
      .map {|f| @reader.read.scan(f) }
      .flatten
  end
    
end
