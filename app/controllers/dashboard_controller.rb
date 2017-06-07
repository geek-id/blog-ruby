class DashboardController < ApplicationController
  layout "dashboard"
  add_breadcrumb "Dashboard", :dashboard_path

  def new
    # add_breadcrumb "Dashboard", dashboard_path

    # @user = User.find(params[:id])
    if !logged_in?
      redirect_to login_url
    end
    @post = Post.where(published: true).paginate(page: params[:page], per_page: 5)
    @users = User.all
  end

  # def show
  #   @user = User.find(params[:id])
  # end
  #
  # def edit
  #   @user = User.find(params[:id])
  # end
  #
  # def create
  # end


end
