class BraintreeController < ApplicationController

	def new
	  @client_token = Braintree::ClientToken.generate
	  @reservation = Reservation.find(params[:id])
	end

	def checkout
	  @reservation = Reservation.find(params[:id])
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => @reservation.total_price,
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	transaction = result.transaction
	  	flash[:payment_success] = "Transaction successful! Your transaction ref: #{transaction}"
	    redirect_to homepage_path
	  else
		result.errors.each do |error|
			puts error.attribute
			puts error.code
			puts error.message
		end
	  	flash[:payment_error] = "Transaction failed. #{result.message} Please try again."
	  	redirect_back(fallback_location: homepage_path)
	  end
	end

end
