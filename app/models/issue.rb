class Issue 
  include MongoMapper::Document
  
  key :account_id, ObjectId, :required => true
  key :name, String, :required => true
  key :description, String
  key :projected, Date
  key :notes, Array
  timestamps!
  
  attr_accessible :account_id, :description, :name, :new_note
  attr_accessor :new_note
  attr_reader :new_note
  has_many :ticket
  has_many :note
  
  def new_note=(new_note)
  end
  
end