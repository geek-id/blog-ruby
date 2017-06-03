class SessionsController < ApplicationController
  layout "login"
  def new
    if logged_in?
      redirect_to dashboard_url
    end
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:sessions][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to dashboard_url
      # redirect_back_or user
    else
      # Create an error message.
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end
