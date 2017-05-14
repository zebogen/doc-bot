class CreateConsultations < ActiveRecord::Migration[5.1]
  def change
    create_table :consultations do |t|
      t.string :facebook_id, null: false
      t.integer :current_sequence_number, null: false, default: 1

      t.timestamps
    end
  end
end
