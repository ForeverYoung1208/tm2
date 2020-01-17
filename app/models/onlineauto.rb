class Onlineauto < ActiveRecord::Base
  belongs_to :aauto;
  belongs_to :odate;
 
  validates :aauto_id, :presence=>true;
  validates :odate_id, :presence=>true;

  def aauto_name_autodesc
  	self.aauto.name_autodesc
  end

  def work_time
    total_duration = 0
    aauto.aorders.where("odate_id = ?", odate.id).each do |order|
      total_duration +=order.duration_seconds
    end
    Time.at(total_duration).utc.strftime("%H:%M")

  end

  def self.find_all_by_odate_id_puls_empty(odate)
  	# res = self.find_all_by_odate_id(odate)
    res = self.where('odate_id = ?',odate).to_a
  	emptyauto = Onlineauto.new(odate_id: odate, aauto_id: ::NOAUTO_ID)
  	res << emptyauto
  end

end
