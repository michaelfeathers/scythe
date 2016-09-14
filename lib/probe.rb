
$:.unshift File.dirname(__FILE__)

require 'date'

class Probe
  attr_reader :name

  def initialize name, mod_date 
    @name = name
    @mod_date = mod_date
  end

  def days_silent? date_now 
    check_day = Time.at(date_now).to_datetime.mjd
    mod_day = Time.at(@mod_date).to_datetime.mjd

    [0, (check_day - mod_day)].max
  end
end
