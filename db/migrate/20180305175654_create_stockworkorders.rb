class CreateStockworkorders < ActiveRecord::Migration[5.1]
  def change
    create_table :stockworkorders do |t|
      t.integer :user_id
      t.string :locno
      t.string :erpno
      t.string :projectname
      t.string :projectvalue
      t.string :branch
      t.string :gmname
      t.string :projectincharge
      t.string :billingeng

      t.timestamps
    end
  end
end
