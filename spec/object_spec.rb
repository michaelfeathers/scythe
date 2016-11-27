

require 'functions'

describe Object do

  it 'returns filenames from a valid file spec' do
    expect(file_names("spec/data/good").grep(/\.rb$/).count).to eq(1)
  end

end
