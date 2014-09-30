class ProductionUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :production
end
