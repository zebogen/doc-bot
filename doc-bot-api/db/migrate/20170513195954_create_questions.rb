class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :slug, null: false, unique: true
      t.string :text, null: false, unique: true
      t.integer :sequence_number, null: false
      t.string :answer_type, null: false

      t.timestamps
    end
  end
end
