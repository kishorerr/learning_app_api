class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_enum :content_type, %w(video pdf)
    create_table :contents do |t|
      t.enum :content, enum_type: :content_type
      t.string :link
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
