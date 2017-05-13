class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.integer :insurer_id, null: false
      t.string :uid, null: false, unique: true
      t.string :name, null: false

      t.timestamps

      t.index :uid
      t.index :insurer_id
    end
  end
end
