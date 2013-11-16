class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    if current_user.has_payment_info?
      current_user.with_braintree_data!
      @credit_card = current_user.default_credit_card
      #@product = Product.find(params[:product_id])
      @payment_option = PaymentOption.find(params[:payment_option_id])
    else
      session[:payment_option_id] = params[:payment_option_id]
      redirect_to new_customer_path
    end
  end

  def confirm
    @result = Braintree::TransparentRedirect.confirm(request.query_string)

    @payment_option = PaymentOption.find(params[:payment_option_id])

    if @result.success?

      #Here goes  updating the progressbar using Order.prefill and Order.postfill 
     @order = Order.prefill!(
        :name => Settings.product_name, 
        :price => @payment_option.amount, 
        :user_id => current_user.id, 
        :payment_option => @payment_option
      )
     
     @order.token = @result.transaction.id
     @order.save!

      render :confirm
    else
      #@product = Product.find(params[:product_id])
      current_user.with_braintree_data!
      @credit_card = current_user.default_credit_card
      render :new
    end
  end

end
