class Aauto < ActiveRecord::Base
  has_many :aorders;
 
  has_many :onlideautos;
  has_many :odate, :through=>:onlineautos;

  def name_autodesc
  	self.name+' ('+self.autodesc+')'
  end

  def self.used_in_orders(aorders)
		auto_ids=[]
		aorders.each {|aorder| auto_ids<<aorder.aauto.id }
		Aauto.where(id: auto_ids)
  end
 
end
