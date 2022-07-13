class CreateQnResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :qn_responses do |t|
      t.string :selected_option
      t.boolean :marked_for_review, default: false
      t.integer :score, default: 0
      t.references :question, null: false, foreign_key: true
      t.references :attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
