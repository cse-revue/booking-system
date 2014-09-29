class Theatre < ActiveRecord::Base
  has_many :segments
  has_many :productions
end
