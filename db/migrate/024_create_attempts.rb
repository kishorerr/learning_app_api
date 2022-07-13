class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.integer :score
      t.datetime :attempted_at
      t.datetime :finished_at
      t.references :exercise, null: false, foreign_key: true
      t.references :student_enroll, null: false, foreign_key: true

      t.timestamps
    end
  end
end
