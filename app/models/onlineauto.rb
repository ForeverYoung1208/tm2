class Onlinedriver < ActiveRecord::Base
  belongs_to :adriver;
  belongs_to :odate;
 
  validates :adriver_id, :presence=>true;
  validates :odate_id, :presence=>true;


end
