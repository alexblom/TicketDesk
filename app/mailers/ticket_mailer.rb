class TicketMailer < ActionMailer::Base
  
  def ticket_response(ticket, ticket_response)
    @ticket = ticket
    @customer = Customer.find_by_id(@ticket.customer_id)
    @from = Account.find_by_id(@customer.account_id).email
    @ticket_response = ticket_response

    subject = "New response to " + @ticket.name + ",:" + @ticket.id + ":ID"
    mail(:to => @customer.email, :subject => subject, :from => @from) 
  end

  def ticket_closed(ticket)
    @ticket = ticket
    @customer = Customer.find_by_id(@ticket.customer_id)
    from = Account.find_by_id(@customer.account_id).email
      
    subject =  "Your ticket, " + @ticket.name + "has been marked as closed,:" + @ticket.id + ":ID"
    mail(:to => @customer.email, :subject => subject, :from => from)
  end
  
  def issue_update(ticket, issue_update)
    @ticket = ticket
    @issue_update = issue_update
    @customer = Customer.find_by_id(@ticket.customer_id)
    from = Account.find_by_id(@customer.account_id).email
  #  @issue_update = issue_update
      
    subject = "New response to " + @ticket.name + ",:" + @ticket.id + ":ID"
    mail(:to => @customer.email, :subject => subject, :from => from)
  end
    
    
end
