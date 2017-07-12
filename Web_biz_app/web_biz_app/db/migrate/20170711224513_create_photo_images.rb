class CreatePhotoImages < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_images do |t|
      t.references :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
