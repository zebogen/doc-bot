class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.float :distance
      t.string :city
      t.string :state
      t.string :street
      t.string :zip
      t.string :street2
      t.string :phone
      t.string :npi, null: false, unique: true
      t.string :gender
      t.string :yelp_id
      t.integer :last_degree_year
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
