class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :consultation_id
      t.integer :question_id
      t.string :value

      t.timestamps

      t.index [:consultation_id, :question_id], unique: true
    end
  end
end
