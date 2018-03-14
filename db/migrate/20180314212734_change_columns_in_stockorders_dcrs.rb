class ChangeColumnsInStockordersDcrs < ActiveRecord::Migration[5.1]
  def up
  	change_column :dcrs, :cumrecqty, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :recqty, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :cumconqty, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :cons, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :balatsite, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :premonthbal, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :presentbal, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :cumrecqtytotal, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :cumconqtytotal, :decimal, :precision => 20, :scale => 10
  	change_column :dcrs, :balatsitetotal, :decimal, :precision => 20, :scale => 10

  	change_column :itemlists, :matqty, :decimal, :precision => 20, :scale => 10
  	change_column :itemlists, :cumrecqtystart, :decimal, :precision => 20, :scale => 10
  	change_column :itemlists, :cumconqtystart, :decimal, :precision => 20, :scale => 10
  	change_column :itemlists, :balatsitestart, :decimal, :precision => 20, :scale => 10
  end

  def down
  	change_column :dcrs, :cumrecqty, :integer
  	change_column :dcrs, :recqty, :integer
  	change_column :dcrs, :cumconqty, :integer
  	change_column :dcrs, :cons, :integer
  	change_column :dcrs, :balatsite, :integer
  	change_column :dcrs, :premonthbal, :integer
  	change_column :dcrs, :presentbal, :integer
  	change_column :dcrs, :cumrecqtytotal, :integer
  	change_column :dcrs, :cumconqtytotal, :integer
  	change_column :dcrs, :balatsitetotal, :integer

  	change_column :itemlists, :matqty, :integer
  	change_column :itemlists, :cumrecqtystart, :integer
  	change_column :itemlists, :cumconqtystart, :integer
  	change_column :itemlists, :balatsitestart, :integer
  end
end
