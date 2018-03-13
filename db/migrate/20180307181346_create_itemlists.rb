class CreateItemlists < ActiveRecord::Migration[5.1]
  def change
    create_table :itemlists do |t|
      t.references :stockworkorder, foreign_key: true
      t.string :itemno
      t.string :itemname
      t.string :units
      t.integer :matqty

      t.timestamps
    end
  end
end
