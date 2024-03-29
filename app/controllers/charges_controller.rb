class ChargesController < ApplicationController
  def new

  end

  def create
    amount = 5000 # amount in cents

    customer = Stripe::Customer.create(
      :email => 'stripe@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount   => amount,
      :description => 'Rails Stripe customer',
      :currency => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
