class User
  include MongoMapper::Document

  key :account_id, ObjectId, :required => true
  key :email, String, :required => true
  key :name, String
  key :password_hash, String
  key :password_salt, String
  
  attr_accessible :account_id, :account, :email, :password, :password_confirmation

  attr_accessor :password
  attr_accessor :account
  attr_reader :account
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email, :scope => :account_id

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end


