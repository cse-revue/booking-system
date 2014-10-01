class Production < ActiveRecord::Base
  belongs_to :theatre
  has_many :performances
  has_many :production_users
  has_and_belongs_to_many :users, join_table: 'production_users'

  def full_title
    "#{pretitle}: #{title}"
  end

  def seat_statuses
    SeatStatus.joins(:performance).where(performances: {production_id: self.id})
  end

  def ticketers
    users
  end

  def non_ticketers
    User.find :all, conditions: ['id not in (?)', ticketers.map{|x|x.id}]
  end

  def qseats
    Seat.joins(<<-EOF
    INNER JOIN seat_statuses ON seat_statuses.seat_id = seats.id 
    INNER JOIN performances ON seat_statuses.performance_id = performances.id
    EOF
    ).where(performances: {production_id: self.id})
  end

  def seats
    qseats
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

  def opening_time
    performances.map{|p| p.start}.sort.first
  end

  def <=> (other)
    unless opening_time.nil? or other.opening_time.nil?
      return opening_time <=> other.opening_time
    end
    return 0
  end
end
