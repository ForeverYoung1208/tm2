class Onlineauto < ActiveRecord::Base
  belongs_to :aauto;
  belongs_to :odate;
 
  validates :aauto_id, :presence=>true;
  validates :odate_id, :presence=>true;

  def aauto_name_autodesc
  	self.aauto.name_autodesc
  end

  def self.find_all_by_odate_id_puls_empty(odate)
  	res = self.find_all_by_odate_id(odate)
  	emptyauto = Onlineauto.new(odate_id: odate, aauto_id: ::NILDRIVER)
  	res << emptyauto
  end

end
