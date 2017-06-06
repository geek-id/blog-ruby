class DashboardController < ApplicationController
  layout "dashboard"
  def new
    # @user = User.find(params[:id])
    if !logged_in?
      redirect_to login_url
    end
    @post = Post.where(published: true)
    @user = User.all
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
