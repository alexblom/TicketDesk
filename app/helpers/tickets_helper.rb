module TicketsHelper

def ticket_issues(ticket)
  #Create an array of issues, based on the issues id's
  issue_array = ticket.issueid
  issues = Array.new
  issue_array.each do |i|
    issues.push(Issue.find_by_id(i))
  end
  
  return issues
end


def response_pending(ticket)
  #Find the last issue and see if it was a user or customer
  user_or_customer = "You"
  
  if (ticket.response.size > 0)
  last_user_id = ticket.response.last['user']
  user_or_customer = "Customer" if (Customer.find_by_id(last_user_id))
  end

  return user_or_customer
end

def is_customer(id)
  customer = Customer.find_by_id(id)
  return true if (customer)
end

def customer_or_user_name_by_id(id)  
  user = User.find_by_id(id)
  if user
    return user.name
  end
  
  customer = Customer.find_by_id(id)
  if customer
    return customer.name
  end

end
    
  
end
