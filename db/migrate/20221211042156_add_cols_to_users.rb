class AddColsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string # will contain google, facebook or twitter
    add_column :users, :avatar_url, :string
  end
end
