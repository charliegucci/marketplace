class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    # this should be properly filled from the form
    @listing.breed = Breed.first unless @listing.breed

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @listing = Listing.find_by(id: params[:id])
  end

def show
   @listing = Listing.find_by(id: params[:id]) 
end

  def destroy
    @listing = Listing.find_by(id: params[:id])
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_path, notice: 'Listing was successfully destroyed.' }
    end
  end

  def update
    @listing = Listing.find_by(id: params[:id])
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

  def listing_params
    params.require(:listing).permit(:description, :breed, :breeder_prefix)
  end
end
