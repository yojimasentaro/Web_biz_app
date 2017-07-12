class AddLikesCOuntToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :likes_count, :integer
  end
end
