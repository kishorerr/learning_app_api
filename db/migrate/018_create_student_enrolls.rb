class CreateStudentEnrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :student_enrolls do |t|
      t.integer :otp
      t.timestamp :otp_generated_at
      t.references :student, foreign_key: true
      t.references :board, foreign_key: true
      t.references :s_class, foreign_key: true
      t.timestamps
    end
  end
end
