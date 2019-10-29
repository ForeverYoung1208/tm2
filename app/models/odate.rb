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
#      de.each {|e| text += 'Авто: '+Aauto.find_by_id(e[:auto_id]).name_autodesc+' Заказ № '+e[:order_id].to_s+', '+e[:message]+'</br>' }
      de.each {|e| text += 'Заказ № '+e[:order_id].to_s+', '+e[:message]+'</br>' }
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


  # private

  def day_errors
    test1_errors=[]

    # по каждому авто которые есть в заказах в данной (self) дате
    self.aorders.select(:aauto_id).uniq.map{|aorder| aorder.aauto_id }.each do |current_auto_id|
      last_odoend=0
      prev_order=nil
      total_distance=0

      #introduce array of possible aauto ids in case if one car shares different drivers.  (synonims)
      #we will check the "autonumber" parameter to understand if this is the same car
      current_auto_id ? current_autonuber = Aauto.find(current_auto_id).autonumber : current_autonuber = null
      possible_auto_ids = Aauto.where("autonumber LIKE ?", current_autonuber).pluck(:id)

      # По каждому заказу в которых есть данное авто (отсортированы по спидометру)

      # self.aorders.where( "aauto_id = ?", current_auto_id ).order(:odobegin).order(:odoend).to_a.each do |current_order|
      # переделаем на все заказы за месяц
      # будем чекать все заказы с начала текущего месяца до даты чекания (self)
      dates_ids = Odate.where("thedate >= ? AND thedate <=?",self.thedate.beginning_of_month.to_s, self.thedate).pluck(:id)
      processing_orders = Aorder.where( "aauto_id IN (?) AND odate_id IN (?)", possible_auto_ids, dates_ids ).order(:odobegin).order(:odoend)
      processing_orders.to_a.each do |current_order|
        if !current_order.iscanceled?

          # проверка на стыковку пробега на то что нет разырвов в показаниях спидометра
          if (current_order.odobegin != last_odoend) and last_odoend != 0 and current_auto_id!=::NOAUTO_ID then 
            test1_errors << { auto_id: current_auto_id, order_id: current_order.id, 
              message: "разрыв в показаниях спидометра заказов № #{prev_order.id} от #{prev_order.odate.thedate} и #{current_order.id} от #{current_order.odate.thedate} : #{last_odoend} - #{current_order.odobegin}"}
          end

          # проверка на внесение пробега
          if current_order.distance == 0 and current_order.comment=='' and current_auto_id!=::NOAUTO_ID 
            test1_errors << { order_id: current_order.id, message: "У заказа № #{current_order.id} от #{current_order.odate.thedate} нулевой пробег без указания примечания" } if current_auto_id
          end

          last_odoend=current_order.odoend
          prev_order=current_order
          total_distance=+current_order.distance
        end
      end



      # проверка на внесение пробега за день
      #if total_distance == 0 and current_auto_id!=::NOAUTO_ID
      #  test1_errors << { message: "За весь день нет пробега у автомобиля #{Aauto.find_by_id(current_auto_id).name_autodesc.to_s}  " } if current_auto_id
      #end

    end

    # проверка на назначение авто
    if err_orders_wo_auto=self.aorders.where( 'aauto_id IS NULL')
      err_orders_wo_auto.each do |current_order|
        if !current_order.iscanceled?
          test1_errors << { order_id: current_order.id, message: "Не назначена машина у заказа №: #{current_order.id}"}
        end
      end
    end

    test1_errors
  end
  
end
