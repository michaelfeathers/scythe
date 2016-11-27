

require 'ruby_gatherer'

class TextReader
  def initialize text; @text = text; end

  def read; @text; end
end


describe RubyGatherer do

  def gatherer_on text
    RubyGatherer.new(TextReader.new(text))
  end

  it 'gathers no markers from a reader' do
    expect(gatherer_on("some text").markers)
      .to eq([])
  end

  it 'gathers a parenthesized marker' do
    expect(gatherer_on("scythe_probe(\"a\")").markers)
      .to eq(["a"])
  end

end

