class Host::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  # GET host/listings/:listing_id/rooms
  def index
    @rooms = @listing.rooms.all
    @room = @listing.rooms.build
  end

  # POST host/listings/:listing_id/rooms
  def create
    @room = @listing.rooms.build(room_params)

    flash[:errors] = @room.errors.full_messages if !@room.save

    redirect_to host_listing_rooms_path(@listing)
  end

  def set_listing
    @listing = current_user.listings.find(params[:listing_id])
  end

  private

  def room_params
    params.require(:room).permit(:room_type)
  end
end
