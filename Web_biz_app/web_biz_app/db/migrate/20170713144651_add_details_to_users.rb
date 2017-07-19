class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :photographer_flg, :boolean
    add_column :users, :model_flg, :boolean
    add_column :users, :camera, :string
    add_column :users, :organization, :string
  end
end
