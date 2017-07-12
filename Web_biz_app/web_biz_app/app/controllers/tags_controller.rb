class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag        = ActsAsTaggableOn::Tag.find_by(name: params[:name])
    @photos = Photo.tagged_with(@tag).includes([:user, :tags])
  end
end
