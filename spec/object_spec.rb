

require 'functions'

describe Object do

  it 'returns filenames from a valid file spec' do
    expect(file_names("spec/data").grep(/b\.rb$/).count).to eq(1)
  end

  it 'knows a ruby marker pattern' do
    expect(RUBY_MARKER_PATTERN =~ "scythe_probe ( \"this\" ) ").to eq(0)
  end

end
