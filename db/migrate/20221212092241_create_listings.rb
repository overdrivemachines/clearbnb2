class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :about
      t.integer :max_guests, default: 2
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.string :latitude, precision: 10, scale: 6
      t.string :longitude, precision: 10, scale: 6
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.integer :status, default: 0 # draft or published

      t.timestamps
    end
  end
end
