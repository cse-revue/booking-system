class Segment < ActiveRecord::Base
  has_many :seats
  belongs_to :theatre
  has_and_belongs_to_many :performances

end
