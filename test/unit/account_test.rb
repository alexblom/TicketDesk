require 'test_helper'
 
class AccountTest < ActiveSupport::TestCase
  test "account cannot be created without required fields" do
    account = Account.new
    assert account.invalid?
    assert account.errors[:name].any?
    assert account.errors[:email].any?
  end
end