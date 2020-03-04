class HomeController < ApplicationController
  def index
    @users = User.all
    @user_count = User.count
    # @share = request.url (share feature link)
    @listings = Listing.search(params[:search])
  end

  def show
    @listing = Listing.find_by(id: params[:id])
  end

end




