class SubcriberController < ApplicationController
  def new
    @subcriber = Subcriber.new
  end

  def create
    @subcriber = Subcriber.new(subcriber_params)
    if @subcriber.save
      cookies[:saved_lead] = true
      flash[:success] = "Thanks for subscription !"
      redirect_to root_path
    else
      flash[:info] = "Your email has been subscription"
      redirect_to root_path
    end
  end


  private
    def subcriber_params
      params.require(:subcriber).permit(:name, :email)
    end
end
