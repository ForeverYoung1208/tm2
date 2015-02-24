class Department < ActiveRecord::Base
  belongs_to :company
  
  validates :company, :presence => true
end
