class SeatStatus < ActiveRecord::Base
  belongs_to :seat
  belongs_to :performance
end
