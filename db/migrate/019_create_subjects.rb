class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :s_name
      t.binary :s_logo
      t.references :s_class, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
