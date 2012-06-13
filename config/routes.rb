Ticketdesk::Application.routes.draw do
  
  get "sessions/new"

  get "users/new"

  resources :tickets do
    put 'ticket_response', :on => :member
    get 'close_ticket', :on => :member
    put 'add_issues', :on => :member
  end
  resources :customers
  resources :issues do
    put 'add_note', :on => :member
    put 'create_from_partial', :on => :member
  end
  resources :users
  resources :sessions
  resources :accounts do
    put 'new', :on => :member
  end
  
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "accounts#new", :as => "sign_up"
  
  
  root :to => "tickets#index"

end
