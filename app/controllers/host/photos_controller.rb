class Host::PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  # GET host/listings/:listing_id/photos
  def index
    @photos = @listing.photos
    @photo = @listing.photos.build
  end

  # POST host/listings/:listing_id/photos
  def create
    @photo = @listing.photos.new(photo_params)

    if @photo.save
      flash[:info] = "Photo was saved"
    else
      flash[:errors] = @photo.errors.full_messages
    end

    redirect_to host_listing_photos_path(@listing)
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
