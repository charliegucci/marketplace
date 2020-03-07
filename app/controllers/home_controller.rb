class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:contact_seller]
  def new
  end

  def index
    @users = User.all
    @user_count = User.count
    # @share = request.url (share feature link)
    @pagy, @listings = pagy(Listing.search(params[:search]))
  end

  def show
    @listing = Listing.find_by(id: params[:id])
  end

  def contact_seller
    @user = current_user
    @user.contact_seller_email(params[:id])
    flash[:notice] = "Successfully Email the Seller. The Seller will be contacting you directly."
    redirect_to root_path
  end
end




