class HomeController < ApplicationController
  def index
    @users = User.all
    @user_count = User.count
    @share = request.url
    if params[:search]
      @listings = Listing.search(params[:search])
    else
      @listings = Listing.all
    end
  end

  def blank
  end

end




