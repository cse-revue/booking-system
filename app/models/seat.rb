class Seat < ActiveRecord::Base
  belongs_to :segment
  has_many :seat_statuses

  def theatre
    segment.theatre
  end

end
