class PostsController < ApplicationController
  layout "dashboard"
  before_action :logged_in_user, only: [:index, :create, :destroy]
  # rescue_from ActiveRecord::RecordNotFound, with: :invalid_post
  # rescue_from ActionController::RoutingError, with: :render_not_found
  # rescue_from StandardError, with: :render_server_error
  # before_action :correct_user,   only: :destroy
  # raise ActionController::RoutingError.new('Not Found')
  # around_action :rescue_from_fk_contraint, only: [:destroy]


  def index
    @posts = Post.where(published: true).paginate(page: params[:page], per_page: 5)
  end

  def new
    logged_in_user
    @post = Post.new
    # @maximum_length = Post.validators_on( :descriptions).first.options[:maximum]
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save && @post.published == true
      flash[:success] = "Post has been created!"
      redirect_to posts_url
    elsif @post.save && @post.published == false
      flash[:success] = "Post save to draft"
      redirect_to posts_draft_url
    else
      render 'new'
    end
  end

  def draft
    # @user = User.find_by(params[:id])
    @post = Post.where(published: false).paginate(page: params[:page], per_page: 5)
  end

  def destroy
    Post.friendly.find(params[:id]).destroy
    flash[:success] = "Post has been deleted"
    redirect_to posts_url
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update_attributes(post_params) && @post.published == true
      flash[:success] = "Post has been published"
      redirect_to posts_url
    elsif @post.update_attributes(post_params) && @post.published == false
      flash[:info] = "Post save to draft"
      redirect_to posts_draft_url
    else
      render 'edit'
    end
  end

  private
    def post_params
      if params[:published]
        params.require(:post).permit(:title, :content, :images, :descriptions, :all_tags).merge(published: true)
      else
        params.require(:post).permit(:title, :content, :images, :descriptions, :all_tags).merge(published: false)
      end
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # def correct_user
      # @post = current_user.posts.find_by(id: params[:id])
      # redirect_to posts_url if @post.nil?
    # end

    def invalid_post
       logger.error "Attempt to access invalid user #{params[:id]}"
       flash[:danger] = 'Post can`t Found'
       redirect_to post_url
     end

     def not_found
       render "shared/404", status: 404
     end

     def server_error
       render "shared/500", status: 500
     end

end
