require 'test_helper'
 
class UserTest < ActiveSupport::TestCase
  
  test "user cannot be created without required fields" do
    user = User.new
    assert user.invalid?
    assert user.errors[:account_id].any?
    assert user.errors[:email].any?
  end
  
  test "user e-mails are unique" do
    user = User.create(:account_id => 1, :email => "alex@ticketdesk.co", :password => "password")
    assert user.valid?, "Test user for email uniqueness was not created. Further tests may fail"
    
    user_two = User.new(:account_id => 1, :email => user.email, :password => "anotherpassword")
    assert user.invalid?, "User emails are not being enforced as unique"
    assert user.errors[:email].any?, "Specific error with the e-mail field"
  end

  test "user password should be salted / hashed" do
    user = User.create(:account_id => 1, :email => "alex@ticketdesk.co", :password => "password")
    assert_not_nil(user, user.password_hash)
    assert_not_nil(user, user.password_salt)
  end
  
end