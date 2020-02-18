class HomeController < ApplicationController
    def index
        @users = User.all
        @user_count = User.count
    end
end
