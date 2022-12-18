class Host::ListingsController < ApplicationController
  before_action :set_listing, except: [:new, :create, :index]

  # GET /host/listings/new
  def new
    @listing = Listing.new
  end

  # POST /host/listings
  def create
    @listing = current_user.listings.build(listing_create_params)
    if @listing.save
      redirect_to [:host, @listing]
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  # GET /host/listings/:id/edit
  def edit; end

  # PUT/PATCH /host/listings/:id
  def update
    # address cannot be changed during update
    if @listing.update(listing_update_params)
      redirect_to [:host, @listing]
    else
      flash.now[:erros] = @listing.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  # GET /host/listings
  def index
    @listings = current_user.listings
  end

  # GET /host/listings/:id
  def show; end

  # DELETE /host/listings/:id
  def destroy
    @listing.update(status: :archived)
    redirect_to host_listings_path # /host/listings
  end

  private

  def listing_create_params
    params.require(:listing).permit(:title, :about, :max_guests, :address_line1, :address_line2,
                                    :city, :state, :postal_code, :country, :latitude, :longitude)
  end

  def listing_update_params
    # address cannot be changed on update
    params.require(:listing).permit(:title, :about, :max_guests)
  end

  def set_listing
    @listing = current_user.listings.find(params[:id])
  end
end
