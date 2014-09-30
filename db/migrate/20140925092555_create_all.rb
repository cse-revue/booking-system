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
    
    create_table :prices do |t|
      t.string :name
      t.float :price
      t.boolean :admin_only
      t.belongs_to :performance
    end

    create_table :performances do |t|
      t.string :name
      t.belongs_to :production
      t.datetime :start
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

    create_table :seat_statuses do |t|
      t.belongs_to :seat
      t.belongs_to :booking
      t.belongs_to :performance
      t.string :status
      
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :phone
      t.string :session_key
      t.boolean :superadmin
    end

    create_table :production_users do |t|
      t.belongs_to :user
      t.belongs_to :production
      t.boolean :manager
    end

    create_table :closed_segments do |t|
      t.belongs_to :performance
      t.belongs_to :segment
    end
    
    create_table :booking_statistics do |t|
      t.belongs_to :booking
      t.belongs_to :user

      t.string :location
      
      t.timestamps
    end

  end
end
