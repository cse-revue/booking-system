require 'bcrypt'

class User < ActiveRecord::Base
  has_and_belongs_to_many :_productions, class_name: 'Production', join_table: 'production_users'
  has_many :production_users


  attr_accessor :new_password, :new_password_confirmation
  validates_confirmation_of :new_password, if: :password_changed?
  before_save :hash_new_password, if: :password_changed?

  def password_changed?
    !@new_password.blank?
  end

  def to_s
    "#{self.name} (#{self.email})"
  end

  def productions
    if self.superadmin
      Production.all
    else
      self._productions
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
      if BCrypt::Password.new(user.password).is_password? password
        return user
      end
    end
    return nil
  end

  def gravatar_url
    hash = Digest::MD5.hexdigest self.email.downcase
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def can_manage(production)
    if superadmin
      return true
    end
    prod = production_users.find_by production_id: production.id
    unless prod.nil?
      return prod.manager
    end
  end

  def <=> (other)
    self.name <=> other.name
  end

  private
  def hash_new_password
    self.password = BCrypt::Password.create(@new_password)
  end

end
