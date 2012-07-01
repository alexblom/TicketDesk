require 'test_helper'
 
class IssueTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "issue cannot be created without required fields" do
    issue = Issue.new
    assert issue.invalid?
    assert issue.errors[:account_id].any?, "Issues require an account id"
    assert issue.errors[:name].any?, "Issues require a name"
  end
  
end