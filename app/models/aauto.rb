class Aauto < ActiveRecord::Base
  has_many :aorders;
 
  has_many :onlideautos;
  has_many :odate, :through=>:onlineautos;

  def name_autodesc
  	self.name+' ('+self.autodesc+')'
  end

  def self.used_in_orders(aorders)

# Заменил плюком :)))    можно удалить если плюк не будет глючить
#		auto_ids=[]
#		aorders.each {|aorder| auto_ids<<aorder.aauto.id }
#		Aauto.where(id: auto_ids)

   Aauto.where(id: aorders.pluck(:aauto_id))

  end
 
end
