class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_enum :opt_type, %w(correct wrong)
    create_table :options do |t|
      t.string :option_name
      t.string :option
      t.enum :opt_status, enum_type: :opt_type
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
