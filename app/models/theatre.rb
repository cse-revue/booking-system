class Theatre < ActiveRecord::Base
  has_many :segments
  has_many :productions

  def seats
    Seat.joins(:segment).where(segments: {theatre_id: self.id})
  end
end
