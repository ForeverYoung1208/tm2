class Onlineauto < ActiveRecord::Base
  belongs_to :aauto;
  belongs_to :odate;
 
  validates :aauto_id, :presence=>true;
  validates :odate_id, :presence=>true;

  def aauto_name_autodesc
  	self.aauto.name_autodesc
  end

end
