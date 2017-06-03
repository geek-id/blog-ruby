class PostAttachmentController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @postattach = PostAttachment.all
  end

  def upload
    @postattach = PostAttachment.new
    @postattach.attach = params[:file]
    @postattach.save

    respond_to do |format|
        format.json { render :json => { status: 'OK', link: @postattach.attach.url}}
    end
  end

  def destroy
    @postattach = PostAttachment.find(params[:id])
    @postattach.destroy
  end
  
end
