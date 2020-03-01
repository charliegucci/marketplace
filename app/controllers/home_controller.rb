class HomeController < ApplicationController
  def index
    @users = User.all
    @user_count = User.count
    # @share = request.url (share feature link)
    @listings = Listing.search(params[:search])
    @listing = Listing.all 
  end

  def blank
    
  end

end




