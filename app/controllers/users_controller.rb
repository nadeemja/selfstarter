class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  	
  	@user = current_user.with_braintree_data!
  end
end
