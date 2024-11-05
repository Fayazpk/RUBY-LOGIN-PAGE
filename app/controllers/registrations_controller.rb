class RegistrationsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new, :create]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(registration_params) 
    if @user.save
      login(@user)  
      session[:user_id]=@user.id
      redirect_to home_main_path  
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def registration_params  
   params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
