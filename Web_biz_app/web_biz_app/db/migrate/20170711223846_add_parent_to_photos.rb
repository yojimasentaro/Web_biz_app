class AddParentToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :catch_copy, :string
    add_column :photos, :concept,    :text
  end
end
