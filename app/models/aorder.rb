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
  before_update :check_rights;
  before_update :check_is_date_closed;

  attr_accessor :is_updating_odometer
  attr_accessor :ttmid;

# upd. спустя 2 года: странная логика с :ttmid но лень переделывать:
# перед Aorder.save / update в контроллере в ttmid прописывается id пользователя, который
# пытается сохранить/обновить данные, потом вызывается  before_update который дергает check_rights 
# и вот уже тут анализируется этот id
# кстаи логика нормальная а имя свойства конченное. Но таки лень переделывать.

def department_name
  self.department.name
end

  def check_rights
#    Убрали возможность редактировать свои заявки, только админ.
#    if (ttmid.to_i==Aorder.find_by_id(self.id).user_id) or (User.find_by_id(ttmid).userlevel_id==::ADMIN_ID)
    if (User.find_by_id(ttmid).userlevel_id==::ADMIN_ID) or 
        ( (ttmid.to_i==Aorder.find_by_id(self.id).user_id) and (self.aauto_id==nil or self.aauto_id==::NILDRIVER or is_updating_odometer))
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

end


