class CreateDoctorProcedures < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_procedures do |t|
      t.integer :doctor_id, null: false
      t.integer :procedure_id, null: false
      t.integer :count
      t.float :complication_rate

      t.timestamps
    end
  end
end
