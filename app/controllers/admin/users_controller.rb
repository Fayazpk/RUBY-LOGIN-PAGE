class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:search].present?
      @users = User.where(admin: false).where("email LIKE ?", "%#{params[:search]}%")
    else
      @users = User.where(admin: false)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User created successfully.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'Not authorized' unless current_user&.admin?
  end
end
