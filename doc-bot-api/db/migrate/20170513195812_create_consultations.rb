class CreateConsultations < ActiveRecord::Migration[5.1]
  def change
    create_table :consultations do |t|
      t.integer :facebook_id, null: false

      t.timestamps
    end
  end
end
