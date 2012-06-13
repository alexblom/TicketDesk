class Customer 
  include MongoMapper::Document
  
  key :account_id, ObjectId
  key :name, String, :required => true
  key :email, String
  key :company, String
  timestamps!
  
  attr_accessible :account_id, :name, :email, :company
  attr_accessor :name, :account_id
  attr_reader :name, :account_id
  has_many :ticket
  
end
