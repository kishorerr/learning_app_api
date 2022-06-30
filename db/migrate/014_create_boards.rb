class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :b_name, :unique =>  true
      t.string :b_desc

      t.timestamps
    end
  end
end
