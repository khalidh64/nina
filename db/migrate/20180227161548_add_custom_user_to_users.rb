class AddCustomUserToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :mobile, :string
    add_column :users, :employee_code, :string
    add_column :users, :secure_password, :string
  end
end
