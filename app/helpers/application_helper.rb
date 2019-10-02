require 'date'
module ApplicationHelper
######## ???  
  def get_first_login(user_id,day,month,year)
    first_action = Action.where("updated_at> '#{DateTime.new(year, month, day
      ).beginning_of_day.to_s(:db)}' and updated_at< '#{DateTime.new(year, month, day
      ).end_of_day.to_s(:db)}' and user_id=#{user_id}").first

    if first_action
      first_action.updated_at
    else
      nil
    end
  end

  def get_last_login(user_id,day,month,year)
    first_action = Action.where("updated_at> '#{DateTime.new(year, month, day
      ).beginning_of_day.to_s(:db)}' and updated_at< '#{DateTime.new(year, month, day
      ).end_of_day.to_s(:db)}' and user_id=#{user_id}").last

    if first_action
      first_action.updated_at
    else
      nil
    end
  end

  def hm(seconds, decimals = 0)
    int   = seconds.floor
    [int / 3600, (int / 60) % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
  end

end
