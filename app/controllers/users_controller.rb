class UsersController < ApplicationController
  layout "dashboard"
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :create, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user


  def index
    @user = User.all
  end

  def new
    if logged_in? && current_user.admin?
      @user = User.new
    else
      redirect_to dashboard_url
    end
  end

  def show
    logged_in_user
    @user = User.friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to user_profile_url
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # log_in @user
      flash[:success] = "New user was added !"
      redirect_to users_url
    else
      render 'new'
    end
  end

  def destroy
    User.friendly.find(params[:id]).destroy
    flash[:success] = "User has been deleted"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.friendly.find(params[:id])
      # redirect_to(dashboard_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(dashboard_url) unless current_user.admin?
    end

    def invalid_user
      logger.error "Attempt to access invalid user #{params[:id]}"
      flash[:danger] = 'Invalid User'
      redirect_to dashboard_url
    end
end
