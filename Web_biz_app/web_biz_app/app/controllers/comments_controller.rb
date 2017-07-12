class CommentsController < ApplicationController
  before_action :set_photo, only: [:create, :destroy]

  def create
    @comment  = @photo.comments.create(create_comment_params)
    @comments = @photo.comments
    render_js
  end

  def destroy
    Comment.find(params[:id]).destroy
    @comments = @photo.comments
    render_js
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def create_comment_params
    params.require(:comment).permit(:user_id, :photo_id, :content)
  end

  def render_js
    render partial: "comments/js_comment"
  end
end
