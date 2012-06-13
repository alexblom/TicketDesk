class Ticket 
  include MongoMapper::Document
  
  key :account_id, ObjectId
  key :name, String, :required => true
  key :customer_id, ObjectId
  key :issueid, Array
  key :content, String, :required => true
  key :response, Array
  key :status, String
  timestamps!
  
  belongs_to :customer
  has_many :issue
  
  attr_accessible :account_id, :content, :name, :customer_id, :issue_tokens, :issueid, :closed, :submitted_date
  attr_reader :issue_tokens
  
  before_create :set_status
  
  def set_status
    self.status = "Open";
  end
  
end
