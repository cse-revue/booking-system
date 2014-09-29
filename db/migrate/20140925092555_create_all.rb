class CreateAll < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.string :pretitle
      t.string :title
      t.string :webname
      t.text :description
      t.string :contact_email
      t.string :ticket_cc_email
      t.belongs_to :theatre
    end
    
    create_table :performances do |t|
      t.string :name
      t.belongs_to :production
      t.datetime :start
      t.text :prices
    end

    create_table :theatres do |t|
      t.string :name
      t.string :webname
      t.integer :width
    end
    
    create_table :segments do |t|
      t.string :name
      t.integer :height
      t.belongs_to :theatre
    end
    
    create_table :seats do |t|
      t.string :name
      t.integer :x
      t.integer :y
      t.float :percent_x
      t.float :percent_y
      t.belongs_to :segment
    end


    create_table :bookings do |t|
      t.belongs_to :performance
      t.string :name
      t.string :email
      t.string :guid
    end

    create_table :unavailable_seats do |t|
      t.string :seat
      t.belongs_to :performance
    end

    create_table :booked_seats do |t|
      t.belongs_to :booking
      t.belongs_to :seat
      t.string :status
      t.timestamps
    end


    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :phone
      t.string :session_key
    end

    create_table :user_productions do |t|
      t.belongs_to :user
      t.belongs_to :production
      t.boolean :manager
    end
    
    create_table :booking_statistics do |t|
      t.belongs_to :booking
      t.belongs_to :user

      t.string :location
      
      t.timestamps
    end

  end
end
