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
  
  def self.get_or_create_by_date(t = Time.now.to_date)
    if not d = Odate.find_by_thedate(t)
      d = Odate.new
      d.thedate=t
      d.isclosed=false
      d.was_used=false
      d.save
    end
    d
  end


  def close_day
    de = day_errors
    if de.empty?
      self.isclosed=true
      self.save
    else
      text = "Невозможно закрыть день - ошибки: </br>"
      de.each {|e| text += 'Авто: '+Aauto.find_by_id(e[:auto_id]).name_autodesc+' Заказ № '+e[:order_id].to_s+', '+e[:message]+'</br>' }
      raise ApplicationController::TraficError.new(text)
    end
  end

  def open_day
    self.isclosed=false
    self.was_used=true
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
      raise ArgumentError.new ("unknown day_action in params")
    end 
    d
  end

  def self.used_in_orders(aorders)
    Odate.where(id: aorders.pluck(:odate_id))
  end


  private

  def day_errors
    test1_errors=[]
    self.aorders.select(:aauto_id).uniq.map{|aorder| aorder.aauto_id }.each do |current_auto_id|
      last_odoend=0
      prev_order_id=0
      # test1 на то что нет разырвов в показаниях спидометра
      self.aorders.where( "aauto_id = ?", current_auto_id ).order(:odobegin).to_a.each do |current_order|
        if !current_order.iscanceled?
          if (current_order.odobegin != last_odoend) and last_odoend != 0 then 
            test1_errors << { auto_id: current_auto_id, order_id: current_order.id, message: "разрыв в показаниях спидометра заказов № #{prev_order_id} и #{current_order.id} : #{last_odoend} - #{current_order.odobegin}"}
          end
          last_odoend=current_order.odoend
          prev_order_id=current_order.id
        end
      end
    end
    test1_errors
  end
  
end
