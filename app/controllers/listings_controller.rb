class ListingsController < ApplicationController
  def index
    @listings = Listing.published
  end

  def show
    @listing = Listing.published.find(params[:id])
    @reservation = @listing.reservations.new
  end
end
