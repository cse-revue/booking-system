class Performance < ActiveRecord::Base
  belongs_to :production
  has_many :prices
  has_many :bookings
  has_many :seat_statuses
  has_and_belongs_to_many :seats, join_table: :seat_statuses
  has_and_belongs_to_many :closed_segments, class_name: 'Segment', join_table: :closed_segments

  def qseats
    Seat.joins(<<-EOF
    INNER JOIN seat_statuses ON seat_statuses.seat_id = seats.id 
    INNER JOIN performances ON seat_statuses.performance_id = performances.id
    EOF
    ).where(performances: {id: self.id})
  end

  def seats_paid
    qseats.where(seat_statuses: {status: 'paid'})
  end

  def seats_pay_at_door
    qseats.where(seat_statuses: {status: 'pay_at_door'})
  end
  
  def seats_vip
    qseats.where(seat_statuses: {status: 'vip'})
  end
  
  def seats_confirmed
    qseats.where(seat_statuses: {status: 'confirmed'})
  end
  
  def seats_unavailable
    qseats.where(seat_statuses: {status: 'unavailable'})
  end

  def seats_filled
    seats_paid + seats_pay_at_door + seats_vip
  end

  def price_for(name)
    self.prices.find_by name: name
  end

  def <=> (other)
    self.start <=> other.start
  end
end
