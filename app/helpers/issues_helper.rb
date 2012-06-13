module IssuesHelper
  
  def total_tickets_by_issue(issue)
    tickets = Ticket.find_all_by_issueid_and_account_id(issue.id.to_s, current_user.account_id)
    return tickets.size
  end
  
  def total_open_tickets_by_issue(issue)
    tickets = Ticket.find_all_by_issueid_and_account_id_and_status(issue.id.to_s, current_user.account_id, 'Open')
    return tickets.size
  end
  
  def total_closed_tickets_by_issue(issue)
    tickets = Ticket.find_all_by_issueid_and_account_id_and_status(issue.id.to_s, current_user.account_id, 'Closed')
    return tickets.size
  end
  
  def new_note(note)
  end
  
  def note_user_name(user)
    submitter = User.find_by_id(user)
    return submitter.name
  end

  
end
