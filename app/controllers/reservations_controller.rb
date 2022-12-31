class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  def index
  end

  # POST /reservations
  def create
    # create the reservation using the params
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      # Create a stripe checkout session
      # https://stripe.com/docs/api/checkout/sessions/create
      checkout_session =
        Stripe::Checkout::Session.create(
          {
            line_items: [
              {
                price_data: {
                  unit_amount: @listing.nightly_price,
                  currency: "usd",
                  product: @listing.stripe_product_id,
                },
                quantity: 1, # Number of nights
              },
              {
                price_data: {
                  unit_amount: @listing.cleaning_fee,
                  currency: "usd",
                  product: "prod_N4i2wtYDKXnZxm", # Cleaning fee product ID from stripe dashboard
                },
                quantity: 1,
              },
            ],
            mode: "payment",
            success_url: reservation_url(@reservation),
            cancel_url: listing_url(@listing),
            customer: current_user.stripe_customer_id,
            metadata: {
              reservation_id: @reservation.id,
            },
            payment_intent_data: {
              metadata: {
                reservation_id: @reservation.id,
              },
            },
          },
        )

      # Save Stripe Checkout Session's ID to DB
      @reservation.update(session_id: checkout_session.id)

      # Redirect to success_url or cancel_url as defined above
      redirect_to checkout_session.url, allow_other_host: true
    else
      flash[:errors] = @reservation.errors.full_messages
      redirect_to listing_path(@listing)
    end
  end

  def show
  end

  private

  def reservation_params
    params.require(:reservation).permit(:listing_id)
  end

  def set_listing
    @listing = Listing.find(params[:reservation][:listing_id])
  end
end
