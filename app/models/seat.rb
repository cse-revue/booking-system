class Seat < ActiveRecord::Base
  belongs_to :segment

  def theatre
    segment.theatre
  end

end
