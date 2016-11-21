class Callist < ActiveRecord::Base
  belongs_to :loadedby
  attr_accessible :data, :isparsed
end
