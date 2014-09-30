class Booking < ActiveRecord::Base
  has_many :seat_statuses
  has_and_belongs_to_many :seats, join_table: :seat_statuses

end
