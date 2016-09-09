

require 'functions'

describe Object do

  it 'returns filenames from a valid file spec' do
    expect(files("spec/data").grep(/a\.rb$/).count).to eq(1)
    expect(files("spec/data").grep(/b\.rb$/).count).to eq(1)
  end

end
