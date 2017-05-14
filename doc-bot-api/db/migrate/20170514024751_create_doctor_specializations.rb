class CreateDoctorSpecializations < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_specializations do |t|
      t.integer :doctor_id, null: false
      t.integer :specialization_id, null: false

      t.timestamps
    end
  end
end
