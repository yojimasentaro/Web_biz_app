class LikesController < ApplicationController
  before_action :set_photo, :set_likes, only: [:create, :destroy]

  def create
    @like  = Like.create(user_id: current_user.id, photo_id: params[:photo_id])
    render_js
  end

  def destroy
    @like = current_user.likes.find_by(photo_id: params[:photo_id])
    @like.destroy
    render_js
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def set_likes
    @likes = Like.where(photo_id: params[:photo_id])
  end

  def render_js
   render partial: "likes/js_like"
  end
end
