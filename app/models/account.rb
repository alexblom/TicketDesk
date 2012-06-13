class Account
  include MongoMapper::Document

  key :name, String, :requied => true
  key :email, String, :required => true
  key :email_password_salt, String
  key :email_password_salt, String

  
  attr_accessible :name, :email, :email_password, :email_password_confirmation
  
  attr_accessor :email_password
    
  before_save :encrypt_email_password
  
  def encrypt_password
    if email_password.present?
      self.email_password_salt = BCrypt::Engine.generate_salt
      self.email_password_hash = BCrypt::Engine.hash_secret(email_password, email_password_salt)
    end
  end  

end
