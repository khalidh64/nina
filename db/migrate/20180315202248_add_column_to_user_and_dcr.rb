class AddColumnToUserAndDcr < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :role, :string
  	add_column :dcrs, :user_id, :integer
  end
end
