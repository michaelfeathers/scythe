
$:.unshift File.dirname(__FILE__)

require 'date'

class Probe
  attr_reader :name

  def initialize name, mod_date 
    @name = name
    @mod_date = mod_date
  end

  def days_silent? date_now 
    # approx secs/day is good enough
    return (seconds_silent?(date_now) / 86400).to_i 
  end

  def hours_silent? date_now
    return (seconds_silent?(date_now) / 3600).to_i
  end

  def seconds_silent? date_now
    check_epoch = Time.at(date_now)
    mod_epoch = Time.at(@mod_date)

    [0, (check_epoch - mod_epoch)].max
  end

  def silent? date_now, interval
    #interval == :seconds ? seconds_silent?(date_now) : days_silent?(date_now)
    case interval
      when :seconds
        seconds_silent?(date_now) 
      when :hours
         hours_silent?(date_now)
      else
        days_silent?(date_now)
    end
  end

end
