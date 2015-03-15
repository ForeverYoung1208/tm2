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
    self.aorders.select(:aauto_id).uniq.map{|aorder| aorder.aauto_id }.each do |current_auto_id|
      km_by_auto=0
      min_km=10000000
      max_km=0
      last_odoend=0
      test1=true
      self.aorders.where( "aauto_id = ?", current_auto_id ).order(odobegin: :asc).find_each do |current_order|
        
        if (current_order.odobegin != last_odoend+1) and last_odoend != 0 then 
          test1=false
        end
        
        km_by_auto += current_order.distance
        min_km = current_order.odobegin if current_order.odobegin < min_km
        max_km = current_order.odoend if current_order.odoend > max_km
      end

      max_km - min_km
##################
    end

    true
  end
  
end
