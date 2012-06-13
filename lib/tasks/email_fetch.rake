desc "Run the IMAP / Email checking script"
task :get_emails => :environment do
  require 'net/imap'
  accounts = Account.all
  accounts.each do |a|
    if a.email && a.email_password
      puts "activated for #{a.email}"
      imap = authenticate_imap(a.email, a.email_password)
      messages = get_messages(imap)
      messages.each do |m|
        process_message(m, imap, a.id)
      end
    delete_messages(imap, messages)
    imap.logout
    end
  end
end


def authenticate_imap(login, password)
   imap = Net::IMAP.new('imap.gmail.com', 993, true)
   imap.login(login, password)
   return imap
 end
 
 def get_messages(imap)
   imap.select("Inbox")
   #Get an array of all messages
   messages = imap.uid_search(["ALL"])
   puts "Messages to process #{messages}"    
   return messages
 end
 
 def process_message(m, imap, account_id)
   #Receive mail message, make a mail object
   data = imap.uid_fetch(m, 'RFC822').first.attr['RFC822']
   email = Mail.new(data)

   #Extract the body and subject - we need this for both options
   body = email.html_part.decoded
   subject = email.subject
   puts "Processing Message #{subject}"  
   fromemail = email.from  
   
   #does the customer exist yet?
   customer = Customer.find_by_email(fromemail)

   #See if this is an existing ticket, by checking for :ID to be appended to the subject
   id = subject[subject.length - 3, subject.length-1]
   
   if (id != ":ID")
     fromname = email[:from].display_names.first
     #create a new customer if they do not yet exist
       if !customer
         customer = Customer.create(:email => fromemail, :name => fromname, :account_id => account_id)
       end
     ticket = Ticket.create(:account_id => account_id, :name => subject, :customer_id => customer.id, :content => body) 
     
   else if (id == ":ID")
     #The end string is 28 chars long, from the first : to the concluding :ID
     ticket_id = subject[subject.length-27, subject.length]
     ticket_id = ticket_id[0, ticket_id.length-3]
     puts "Ticket id is #{ticket_id}"
     ticket = Ticket.find_by_id(ticket_id)
     puts "Adding response to #{ticket.name}"
     ticket.response.push(:ticket_response => body, :user => customer.id)
     ticket.save
   end
   
 end
 
 def delete_messages(imap, messages)
   messages.each do |m|
     imap.uid_store(m, "+FLAGS", [:Deleted])
   end
 end
 
 end
 