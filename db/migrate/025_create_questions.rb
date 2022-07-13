class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :qn_no
      t.string :question
      t.datetime :duration
      t.string :solution
      t.references :exercise, null: false, foreign_key: true
      t.timestamps
    end
  end
end
