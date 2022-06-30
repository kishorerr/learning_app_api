class AddRoleToAdmin < ActiveRecord::Migration[7.0]
  def change
     add_column :admins, :auth_token, :string
     add_column :admins, :ph_no, :string
  end
end
