class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:contact_seller]

  def new
  end

  def landing
  end
  # list all the listings
  def index
    @users = User.all
    @user_count = User.count
    @pagy, @listings = pagy(Listing.search(params[:search]))
  end
  # shows the listing
  def show
    @listing = Listing.find_by(id: params[:id])
  end

end