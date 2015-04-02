# encoding: utf-8

class Aorder < ActiveRecord::Base
  belongs_to :aauto;
  belongs_to :odate;
  belongs_to :user;
  belongs_to :department;
  validates :onname, :presence=>true;
#  validates :ondepartment, :presence=>true; - вместо него просто department
  validates :department, :presence=>true;
  validates :contact, :presence=>true;
  validates :adestination, :presence=>true;
  validates :ftime, :presence=>true;
  validates :totime, :presence=>true;

  validates :odobegin, :presence=>true;
  validates :odoend, :presence=>true;
  validates :outofcity, :presence=>true;


  before_update :check_rights;
  before_update :check_is_date_closed;
  before_validation :replace_nil_with_zero;


  after_save :make_odate_be_used

  attr_accessor :is_updating_odometer
  attr_accessor :ttmid;

# upd. спустя 2 года: странная логика с :ttmid но лень переделывать:
# перед Aorder.save / update в контроллере в ttmid прописывается id пользователя, который
# пытается сохранить/обновить данные, потом вызывается  before_update который дергает check_rights 
# и вот уже тут анализируется этот id
# кстаи логика нормальная а имя свойства конченное. Но таки лень переделывать.

  def replace_nil_with_zero
    self.odobegin = 0 if !self.odobegin
    self.odoend = 0 if !self.odoend
    self.outofcity = 0 if !self.outofcity
  end


  def make_odate_be_used
    self.odate.was_used=true
    self.odate.save!
  end

  def department_name
    self.department.name
  end

  def check_rights
  #    Убрали возможность редактировать свои заявки, только админ.
  #    if (ttmid.to_i==Aorder.find_by_id(self.id).user_id) or (User.find_by_id(ttmid).userlevel_id==::ADMIN_ID)
    if (User.find_by_id(ttmid).userlevel_id==::ADMIN_ID) or 
        ( 
          (ttmid.to_i==self.user_id) and 
          (self.aauto_id==nil or self.aauto_id==::NILDRIVER or is_updating_odometer)
        ) or 
        (User.find_by_id(ttmid).userlevel_id==::DRIVERUSER_ID)
      res=true
    else
      self.errors.add(:ttmid, "нет прав на изменеие, только для Администратора!")
      res=false
    end
    res
  end

  def check_is_date_closed
    res=true
    if odate.isclosed
      res=false
      self.errors.add(:odate, "Невозможно выполнить: дата закрыта!")
    else
      res=true
    end
    res
  end

  def is_d_busy(d_id, t)
    res=false
    if not self.iscanceled
      if (self.ftime.seconds_since_midnight<=t and t<self.totime.seconds_since_midnight) and d_id==self.aauto_id
        res=true
      end
    end
    res
  end

  def distance
    self.odoend-self.odobegin
  end

  def self.get_by_dates(date_begin, date_end, sort_orders_by='aorders.id')
    join_str = "LEFT OUTER JOIN `odates` ON `odates`.`id` = `aorders`.`odate_id`"
    Aorder.joins(join_str).where("thedate >= ? AND thedate <= ? AND iscanceled=false", date_begin, date_end).order(sort_orders_by)
  end

end


