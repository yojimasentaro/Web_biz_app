class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.order("photos.created_at DESC").eager_load(:user, :photo_images).page(params[:page])
    @status = 'newest'
  end

  def new
    @photo        = Photo.new
    @main_content = @photo.photo_images.build
    @sub_contents = 1.times { @photo.photo_images.build }
  end

  def create
    @photo  = current_user.photos.new(create_params)

    if @photo.save
      redirect_to root_path, notice: 'Posted Successfully!'
    else
      render :new, alert: 'Sorry, but something went wrong.'
    end
  end

  def show
    @likes    = Like.where(photo_id: params[:id])
    @comments = @photo.comments.includes(:user).all
    @comment  = @photo.comments.build(user_id: current_user.id) if current_user
  end

  def edit
    @main_content = @photo.photo_images.main
    @sub_contents = @photo.set_sub_contents
  end

  def update
      if @photo.user_id == current_user.id && @photo.update(create_params)
        redirect_to root_path, notice: 'Updated Successfully!'
      else
        render :edit, alert: 'Sorry, but something went wrong.'
      end
  end

  def destroy
    @photo.destroy
    redirect_to root_path, notice: 'Deleted Successfully!'
  end

  private

  def set_photo
    @photo    = Photo.find(params[:id])
  end

  def create_params
    params.require(:photo).permit(
      :title,
      :catch_copy,
      :concept,
      photo_images_attributes: [:id, :content, :role]
      ).merge(tag_list: params[:photo][:tag])
  end

end
