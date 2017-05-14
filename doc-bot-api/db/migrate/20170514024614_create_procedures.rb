class CreateProcedures < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.string :code, null: false, unique: true
      t.string :description, null: false

      t.timestamps
    end
  end
end
