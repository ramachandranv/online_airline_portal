class User < ActiveRecord::Base
  attr_accessible :email, :password

  validates_presence_of :email, :password

  before_save :encrypt_password

  has_many :enquiries

  def encrypt_password
    salt = BCrypt::Engine.generate_salt
    self.salt = salt
    self.encrypted_password = BCrypt::Engine.hash_secret(self.password, salt)
    self.password = nil
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && (user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt))
      return user   
    else
      return nil
    end
  end
end
