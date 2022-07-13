class CreateUserContents < ActiveRecord::Migration[7.0]
  def change
    create_enum :status_type, %w(not_started started completed)
    create_table :user_contents do |t|
      t.boolean :upvote
      t.boolean :downvote
      t.string :notes
      t.references :content, null: false, foreign_key: true
      t.references :student_enroll, null: false, foreign_key: true
      t.enum :status, enum_type: :status_type

      t.timestamps
    end
  end
end
