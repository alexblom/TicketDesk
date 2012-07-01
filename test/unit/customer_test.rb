require 'test_helper'
 
class CustomerTest < ActiveSupport::TestCase

  test "customer cannot be created without required fields" do
    customer = Customer.new
    assert customer.invalid?
    assert customer.errors[:name].any?
  end

end