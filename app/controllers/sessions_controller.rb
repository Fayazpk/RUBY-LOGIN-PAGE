class SessionsController < ApplicationController
    before_action :redirect_if_authenticated, only: [:new, :create]
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            if user.admin?
                redirect_to admin_users_path, notice: 'Logged in as admin successfully'
            else
                redirect_to home_main_path, notice: 'Logged in successfully'
            end
        else
            flash.now[:alert] = 'Invalid email or password'
            render :new, status: :unprocessable_entity 
        end
    end

    def destroy
        logout
        redirect_to root_path, notice: 'Logged out successfully'
    end

    def redirect_if_authenticated
        redirect_to home_main_path if user_signed_in?
    end
end
