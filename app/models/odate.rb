# encoding: utf-8

class Odate < ActiveRecord::Base
    has_many :aorders;
 
    has_many :onlinerivers;
    has_many :adrivers, :through=>:onlinedrivers;

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
  
end
