

require 'probe'

describe Probe do

  it 'calculates days silent from now as zero' do
    now = Time.now.to_i
    expect(Probe.new("example", now).days_silent?(now)).to eq(0)
  end

  it 'calculates one day silent' do
    day = DateTime.parse('2001-01-01').to_time.to_i
    next_day = DateTime.parse('2001-01-02').to_time.to_i

    probe = Probe.new("example", day) 
    expect(probe.days_silent?(next_day)).to eq(1)
  end

  it "saturates days when mod time is after check time" do
    check_time = DateTime.parse('2001-01-01').to_time.to_i
    mod_time = DateTime.parse('2001-01-02').to_time.to_i

    probe = Probe.new("example", mod_time) 
    expect(probe.days_silent?(check_time)).to eq(0)
  end

end
