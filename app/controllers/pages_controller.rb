class PagesController < ApplicationController
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

    @post = Post.friendly.find(params[:id])
    # if request.path != content_path(@post)
    #   redirect_to @post, status: :moved_permanently
    # end

    @subcriber = Subcriber.new
  end

  def tag
    @posts = Post.where(published: true).order("created_at DESC").limit(5)
    if params[:tag]
      @post = Post.tagged_with(params[:tag])
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

end
