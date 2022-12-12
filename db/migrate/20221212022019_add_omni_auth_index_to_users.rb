class AddOmniAuthIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :uid
    add_index :users, [:provider, :uid]
  end
end
