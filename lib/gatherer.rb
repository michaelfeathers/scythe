
$:.unshift File.dirname(__FILE__)

class Gatherer
  def initialize text
    @text = text
  end

  def markers
    paren_form = Regexp.new('scythe_probe\s*\(\s*\"(\w+)\"\s*\)')
    parenless_form = Regexp.new('scythe_probe\s*\"(\w+)\"')

    [paren_form, parenless_form]
      .map {|f| @text.scan(f) }
      .flatten
  end
    
end
