class ListingsController < ApplicationController
  # devise helper to authenticate first
  before_action :authenticate_user! 

  # list the listings
  def index
    @pagy, @listings = pagy(Listing.where(user: current_user))
    authorize(@listings) # pundit authorization
    @user = current_user
  end

  # define new listing
  def new
    @listing = Listing.new
    authorize(@listing) # pundit authorization
  end

  # creates new listing
  def create
    @listing = Listing.new(listing_params.merge(user: current_user))
    authorize(@listing) # pundit authorization
# checked if save
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
      else
        format.html do
          flash[:alert] = "Listing was not created due to the following: #{@listing.errors.full_messages.join(', ')}"
          render :new
        end
      end
    end
  end

  # edit listing
  def edit
    @listing = Listing.find_by(id: params[:id])
    authorize(@listing) # pundit authorization
  end

  # show listing
  def show
    @listing = Listing.find_by(id: params[:id])
    authorize(@listing) # pundit authorization
  end

  # delete listing
  def destroy
    @listing = Listing.find_by(id: params[:id])
    authorize(@listing) # pundit authorization

    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_path, notice: 'Listing was successfully destroyed.' }
    end
  end

  # updates listing
  def update
    @listing = Listing.find_by(id: params[:id])
    authorize(@listing) # pundit authorization

    respond_to do |format|
      if @listing.update(listing_params)
        #format.html { redirect_to @listing, notice: 'User was successfully updated.' }
        format.html { render :show, notice: 'Listing was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  protected
# sanitized params
  def listing_params
    params.require(:listing).permit(:description, :breed_id, :breeder_prefix, :picture)
  end
end
