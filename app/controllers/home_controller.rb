class HomeController < ApplicationController
    before_action :redirect_if_authenticated, only: [:index]
    before_action :authenticate_user!, only: [:main]

    def index
       
    end

    def main
        @user = current_user
    end
end
