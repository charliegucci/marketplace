class HomeController < ApplicationController
  def index
    @users = User.all
    @user_count = User.count
    # @share = request.url (share feature link)
    @listings = Listing.search(params[:search])
  end

  def blank
  end

end




