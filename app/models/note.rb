class Note
  include MongoMapper::Document
  
  key :account_id, ObjectId, :requied => true
  key :issue_id, ObjectId
  key :content, String
  key :user, ObjectId
  key :emailed, Boolean
  timestamps!
  
  attr_accessible :account_id, :issue_id, :user, :content, :created_by, :emailed
  belongs_to :issue


end
