class AddRoleToStudent < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :username, :string
    add_column :students, :auth_token, :string
    add_column :students, :ph_no, :string
    add_column :students, :dob, :date
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
