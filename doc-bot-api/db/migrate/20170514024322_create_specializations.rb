class CreateSpecializations < ActiveRecord::Migration[5.1]
  def change
    create_table :specializations do |t|
      t.string :uid, null: false, unique: true
      t.string :name
      t.string :description
      t.string :practitioner_name

      t.timestamps
    end
  end
end
