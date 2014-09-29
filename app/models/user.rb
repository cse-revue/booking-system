require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :new_password, :new_password_confirmation
  validates_confirmation_of :new_password, if: :password_changed?
  before_save :hash_new_password, if: :password_changed?

  def password_changed?
    !@new_password.blank?
  end

  def to_s
    "#{self.name} (#{self.email})"
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

  private
  def hash_new_password
    self.password = BCrypt::Password.create(@new_password)
  end

end
