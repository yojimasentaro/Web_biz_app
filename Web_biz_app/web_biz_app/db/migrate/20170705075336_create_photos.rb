class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
