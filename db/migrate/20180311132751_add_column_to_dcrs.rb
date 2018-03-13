class AddColumnToDcrs < ActiveRecord::Migration[5.1]
  def change
  	add_column :dcrs, :cumrecqtytotal,:integer
  	add_column :dcrs, :cumconqtytotal,:integer
  	add_column :dcrs, :balatsitetotal,:integer
  	add_column :itemlists, :cumrecqtystart,:integer
  	add_column :itemlists, :cumconqtystart,:integer
  	add_column :itemlists, :balatsitestart,:integer
  	add_column :dcrs, :dcnumber,:string
  end
end
