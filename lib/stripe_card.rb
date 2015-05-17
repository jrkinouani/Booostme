module StripeCard
  def self.charge_user(amount, currency, stripe_token)
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account/apikeys

    # Get the credit card details submitted by the form
    token = stripe_token
    # Create the charge on Stripe's servers - this will charge the user's card
    charge = Stripe::Charge.create(
      :amount => amount, # amount in cents, again
      :currency => currency,
      :source => token,
      :description => "Example charge"
    )
  end
end
