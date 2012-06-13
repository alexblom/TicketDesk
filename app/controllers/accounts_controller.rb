class AccountsController < ApplicationController
  skip_before_filter :require_login
  
  def new
    #No create, as form is also responsible for creating a user
     @account = Account.create(:name => params[:company_name], :email => params[:default_from])
      if @account.save
        #Now create the user / initiate a session
        user = User.create(:email => params[:user_email], :account_id => @account.id, :password => params[:password])
        redirect_to root_path, :notice => "Account created. Please log in to continue."
      end
    end

  
end
