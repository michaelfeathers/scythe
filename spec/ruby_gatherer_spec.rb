

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

  it 'gathers several parenthesized markers' do
    expect(gatherer_on("scythe_probe(\"a_marker\") scythe_probe ( \"and_another_\" )\"").markers)
      .to eq(["a_marker", "and_another_"])
  end

 it 'gathers non-paren form of probe call' do
   expect(gatherer_on("scythe_probe \"a_marker\"").markers)
      .to eq(["a_marker"])
 end


end

