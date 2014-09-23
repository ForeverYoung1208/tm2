class Adriver < ActiveRecord::Base
  has_many :aorders;
 
  has_many :onlidedrivers;
  has_many :odate, :through=>:onlinedrivers;

 
end
