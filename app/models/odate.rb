# encoding: utf-8

class Odate < ActiveRecord::Base
    has_many :aorders;
 
    has_many :onlinerivers;
    has_many :aautos, :through=>:onlineautos;

    validates :thedate, :uniqueness=>true;
    


  def showstatus
    result='не определена'
    result='Закрыт' if isclosed==true
    result='Открыт' if isclosed==false
    result
  end
  
  def self.get_today
    t=Time.now.to_date
    if not d = Odate.find_by_thedate(t)
      d = Odate.new
      d.thedate=t
      d.isclosed=false
      d.save
    end
    d
  end

  def close_day
    if is_day_ok?
      self.isclosed=true
      self.save
    else
      raise "Can't close - day is bad ((("
    end
  end

  def open_day
    self.isclosed=false
    self.save
  end

  def self.set_day_status( p={} )
    if p[:day_action]=='day_close'
      d = Odate.find_by_id(p[:id])
      d.close_day  
    elsif p[:day_action]=='day_open'
      d = Odate.find_by_id(p[:id])
      d.open_day
    else
      raise "unknown day_action in params"
    end 

    d
  end

  private

  def is_day_ok?
    true
  end
  
end
