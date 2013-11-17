Selfstarter::Application.routes.draw do

  root :to => 'preorder#index'
  match '/preorder'               => 'preorder#index'
  get 'preorder/checkout'
  match '/preorder/share/:uuid'   => 'preorder#share', :via => :get
  match '/preorder/ipn'           => 'preorder#ipn', :via => :post
  match '/preorder/prefill'       => 'preorder#prefill'
  match '/preorder/postfill'      => 'preorder#postfill'


  resources :users
  devise_for :users

  # match 'customer/new(/:payment_option_id)' => 'customer#new', :as => :new_customer

  resources :customer, :only => [:new, :edit]
  resources :credit_card_info, :only => [:edit]

  match 'customer/confirm' => 'customer#confirm', :as => :confirm_customer
  match 'credit_card_info/confirm' => 'credit_card_info#confirm', :as => :confirm_credit_card_info
  match 'transactions/:payment_option_id/new' => 'transactions#new', :as => :new_transaction
  match 'transactions/confirm/:payment_option_id' => 'transactions#confirm', :as => :confirm_transaction
  
  match '/welcome' => "welcome#index"
end
