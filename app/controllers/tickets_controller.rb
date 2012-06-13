class TicketsController < ApplicationController
  
  def index
    @tickets = Ticket.find_all_by_account_id_and_status(current_user.account_id, 'Open').sort_by( &:response['user'] )
  end
  
  def new
    @ticket = Ticket.new
    @issues = Issue.all
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      redirect_to @ticket, notice: 'Ticket Added'
    end
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    @customer = Customer.find_by_id(@ticket.customer_id)
    @issues = Issue.find_all_by_id(@ticket.issueid)
  end  
  
  def ticket_response
    ticket = Ticket.find(params[:id])
    ticket.response.push(:ticket_response => params[:ticket_response], :user => current_user.id)
    if ticket.save
      TicketMailer.delay.ticket_response(ticket, params[:ticket_response])
      redirect_to ticket, notice: 'Response Added'
    end
  end
  
  def close_ticket
    ticket = Ticket.find(params[:id])
    ticket.status = 'Closed'
    if ticket.save
      TicketMailer.delay.ticket_closed(ticket)
      redirect_to ticket, notice: 'Ticket Closed'
    end
  end
  
  def add_issues
    ticket = Ticket.find(params[:id])
    #ticket_issue_tokens is a comma separated string, so convert to an array before pushing as an issue
    issues = params[:ticket_issue_tokens].split(",")
    issues.each do |i|
      ticket.issueid.push(i)
    end
    if ticket.save
      redirect_to ticket, notice: 'Issue Added'
    end
  end
  
end
