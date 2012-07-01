require 'test_helper'
 
class TicketTest < ActiveSupport::TestCase
  
  test "ticket cannot be created without required fields" do
    ticket = Ticket.new
    assert ticket.invalid?
    assert ticket.errors[:name].any?, "Tickets require a name"
    assert ticket.errors[:content].any?, "Tickets require content"
  end
  
  test "status is set after create" do
    ticket = Ticket.create(:name => "Ticket", :content => "This is a ticket")
    assert_not_nil(ticket, [:status])
  end

  
end