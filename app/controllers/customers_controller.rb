class CustomersController < ApplicationController
  
  def index
    @customers = Customer.find_all_by_account_id(current_user.account_id)
  end
  
  def show
    @customer = Customer.find(params[:id])
    @open_tickets = Ticket.find_all_by_customer_id_and_status(@customer.id, 'Open')
    @closed_tickets = Ticket.find_all_by_customer_id_and_status(@customer.id, 'Closed')
  end
  
  def customer_tickets(customer)
    customer = Customer.find(params[:id])
    @tickets = Ticket.find_by_customer_id_and_account_id(Customer.id)
  end
  
  
end

