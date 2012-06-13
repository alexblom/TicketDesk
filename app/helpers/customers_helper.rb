module CustomersHelper
  
  def customer_tickets(customer)
    return Ticket.find_all_by_customer_id(customer.id).count
    
  end
  
  def customer_open_tickets(customer)
     return Ticket.find_all_by_customer_id_and_closed(customer.id, 'Open').count
   end
   
end
