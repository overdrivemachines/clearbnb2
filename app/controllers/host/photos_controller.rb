class Host::PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  # GET host/listings/:listing_id/photos
  def index
  end

  # POST host/listings/:listing_id/photos
  def create
  end

  # DELETE host/listings/:listing_id/photos/:id
  def destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :photo)
  end

  def set_listing
    @listing = current_user.listings.find(params[:listing_id])
  end
end
