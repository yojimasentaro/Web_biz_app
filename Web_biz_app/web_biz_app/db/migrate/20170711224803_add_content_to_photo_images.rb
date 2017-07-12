class AddContentToPhotoImages < ActiveRecord::Migration[5.1]
  def change
    add_column :photo_images, :content, :string
    add_column :photo_images, :role,  :integer
  end
end
