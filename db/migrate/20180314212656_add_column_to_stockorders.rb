class AddColumnToStockorders < ActiveRecord::Migration[5.1]
  def change
  	add_column :stockworkorders, :state, :string
  end
end
