class Department < ActiveRecord::Base
  belongs_to :company
  has_many :aorders

  validates :company, :presence => true
end
