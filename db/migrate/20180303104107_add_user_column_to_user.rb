class AddUserColumnToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :workorders, :user_id, :integer
  	add_column :workorders, :admin_id, :integer
  end
end
