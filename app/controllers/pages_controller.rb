class PagesController < ApplicationController
  layout "about", only: [:about]
  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404

  def home
    @post = Post.where(published: true).paginate(page: params[:page], per_page: 5)
    # @tags = Tag.find_by(id: params[:id])
    @posts = Post.where(published: true).order("created_at DESC").limit(5)

    @subcriber = Subcriber.new
  end

  def about
  end

  def show
    @posts = Post.where(published: true).order("created_at DESC").limit(5)

    begin
      @post = Post.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render four_oh_four_path
    rescue ActionController::RoutingError
      render four_oh_four_path
    end

    @subcriber = Subcriber.new
  end

  def tag
    @posts = Post.where(published: true).order("created_at DESC").limit(5)
    if params[:tag]
      begin
        @post = Post.tagged_with(params[:tag])
      rescue ActiveRecord::RecordNotFound
        render four_oh_four_path
      rescue ActionController::RoutingError
        render four_oh_four_path
      end
    else
      @post = Post.all
    end

    @tag = Tag.find_by(name: params[:tag])

    @subcriber = Subcriber.new
  end


  def create
    @subcriber = Subcriber.new(subcriber_params)
    if @subcriber.save
      cookies[:saved_lead] = true
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
    def render_404
      render file: "#{Rails.root}/public/404.html.erb", layout: "application", status: 404
    end

end
