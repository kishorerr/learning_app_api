class CreateSClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :s_classes do |t|
      t.integer :class_no
      t.timestamps
    end
  end
end
