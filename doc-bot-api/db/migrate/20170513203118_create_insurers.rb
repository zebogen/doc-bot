class CreateInsurers < ActiveRecord::Migration[5.1]
  def change
    create_table :insurers do |t|
      t.string :uid, null: false, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
