class ListingsController < ApplicationController
  def index
    @listings = Listing.where(user: current_user)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params.merge(user: current_user))

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
    params.require(:listing).permit(:description, :breed_id, :breeder_prefix)
  end
end
