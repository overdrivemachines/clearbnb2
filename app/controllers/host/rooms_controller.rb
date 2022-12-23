class Host::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  def index
    @rooms = @listing.rooms.all
  end

  def set_listing
    @listing = current_user.listings.find(params[:listing_id])
  end
end
