class AddMemberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :member, :string
    add_column :users, :works, :text
    add_column :users, :username, :string
  end
end
