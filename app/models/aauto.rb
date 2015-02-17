class Aauto < ActiveRecord::Base
  has_many :aorders;
 
  has_many :onlideautos;
  has_many :odate, :through=>:onlineautos;

 
end
