class CreateDcrs < ActiveRecord::Migration[5.1]
  def change
    create_table :dcrs do |t|
      t.references :itemlist, foreign_key: true
      t.references :stockworkorder, foreign_key: true
      t.string :date
      t.integer :cumrecqty
      t.integer :recqty
      t.integer :cumconqty
      t.integer :cons
      t.integer :balatsite
      t.string :month
      t.integer :year
      t.integer :premonthbal
      t.integer :presentbal
      t.text :remarks

      t.timestamps
    end
  end
end
