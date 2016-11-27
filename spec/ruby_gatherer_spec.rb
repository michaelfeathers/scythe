

require 'ruby_gatherer'

class TextReader
  def initialize text
    @text = text
  end

  def read
    @text
  end
end


describe RubyGatherer do

  it 'gathers no markers from a reader' do
    expect(RubyGatherer.new(TextReader.new("some text")).markers).to eq([])
  end

end
