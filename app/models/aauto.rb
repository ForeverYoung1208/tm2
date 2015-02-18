class Aauto < ActiveRecord::Base
  has_many :aorders;
 
  has_many :onlideautos;
  has_many :odate, :through=>:onlineautos;

  def name_autodesc
  	self.name+' ('+self.autodesc+')'
  end
 
end
