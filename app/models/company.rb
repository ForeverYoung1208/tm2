class Company < ActiveRecord::Base
  has_many :users
  has_many :departments
end
