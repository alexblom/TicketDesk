class IssuesController < ApplicationController
  
  def index
      @issue = Issue.find_all_by_account_id(current_user.account_id)
      respond_to do |format|
        format.html
        format.json { render :json => @issue}
      end
  end
  
  def new
    @issue = Issue.new
  end
  
  def create
    #Dep'd, but may re-use
    @issue = Issue.create(params[:issue])
    @issue.account_id = current_user.account_id
    if @issue.save
      redirect_to @issue, notice: 'Issue Added'
    end
  end
  
  def show
    @issue = Issue.find(params[:id])
    @issue_notes = Note.find_all_by_issue_id(@issue.id.to_s).sort_by( &:created_at )
    @ticket = Ticket.find_all_by_issueid_and_status(@issue.id.to_s, 'Open')
    @closed_ticket = Ticket.find_all_by_issueid_and_status(@issue.id.to_s, 'Closed')
  end
  
  def create_from_partial
    issue = Issue.create(:name => params[:name], :description => params[:description], :account_id => current_user.account_id)
    ticket = Ticket.find(params[:id])
    if issue.save
      ticket.issueid.push(issue.id.to_s)
      ticket.save
      redirect_to ticket, notice: 'Issue Created'
    end
  end
  
  def add_note
    issue = Issue.find(params[:id])
    note = Note.create(:account_id => issue.account_id,
                       :issue_id => issue.id,
                       :content => params[:content],
                       :user => current_user.id,
                       :emailed => params[:email])
    
    if note.save
      #Send e-mail updates / close tickets if selected
      issue_update_mail(issue, params[:note]) if params[:email] == "1"
      close_tickets(issue) if params[:close_tickets] == "1"
      redirect_to issue, notice: 'Note Added'
    end
  end
  
  def issue_update_mail(issue, issue_update)
    tickets = Ticket.find_all_by_issueid(issue.id.to_s)
    tickets.each do |t|
      TicketMailer.delay.issue_update(t, issue_update)
    end
  end
  
  def close_tickets(issue)
    tickets = Ticket.find_all_by_issueid(issue.id.to_s)
    tickets.each do |t|
      t.status = "Closed"
      t.save
      TicketMailer.delay.ticket_closed(t)
    end
  end

  
end