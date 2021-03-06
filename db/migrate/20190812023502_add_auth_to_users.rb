class AddAuthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :user_name, :string
    add_column :users, :image_url, :string
  end
end
