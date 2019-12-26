module ReservationsHelper
  def get_color(week_day)
    if week_day == Date.current
      "week_today_color"
    elsif week_day.saturday? 
      "text-primary"
    elsif week_day.sunday?
      "text-danger"
    end
  end 
  
  def get_height(start_time,finish_time,week_day)
    if Date.parse(start_time.to_s) == Date.parse(finish_time.to_s)
      time = ((finish_time - start_time + 1800)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(start_time.to_s) == week_day
      time = ((week_day.end_of_day - start_time)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(finish_time.to_s) == week_day
      time = ((finish_time - week_day.midnight)/60/60)
      (time/24.to_f*1776)
    elsif Date.parse(finish_time.to_s) > week_day && Date.parse(start_time.to_s) < week_day
      1776
    end
  end
  
  def get_position(start_time,finish_time,week_day)
    if Date.parse(start_time.to_s) == Date.parse(finish_time.to_s) || Date.parse(start_time.to_s) == week_day
       time = ((start_time - week_day.midnight)/60/60)
       (time/24.to_f*1776)
    elsif Date.parse(finish_time.to_s) == week_day || (Date.parse(finish_time.to_s) > week_day && Date.parse(start_time.to_s) < week_day)
      0
    end
  end
end
