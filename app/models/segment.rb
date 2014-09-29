class Segment < ActiveRecord::Base
  has_many :seats
  belongs_to :theatre

end
