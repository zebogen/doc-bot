class CreateDoctorPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_plans do |t|
      t.integer :doctor_id, null: false
      t.integer :plan_id, null: false

      t.timestamps
    end
  end
end
