class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.integer :duration
      t.integer :qn_no
      t.integer :attempts_no, default: 0
      t.integer :high_score
      t.string :instructions
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
