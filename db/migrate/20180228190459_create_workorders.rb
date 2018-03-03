class CreateWorkorders < ActiveRecord::Migration[5.1]
  def change
    create_table :workorders do |t|
      t.string :erpno
      t.string :clientname
      t.string :sitename
      t.string :workorderno
      t.string :workorderdate
      t.string :workorder_type
      t.string :workorder_value
      t.string :mobbg_no
      t.string :mobadv
      t.string :matadv
      t.string :retbg
      t.string :perbg
      t.string :pwarrenty
      t.string :workcompdate
      t.text :remarks

      t.timestamps
    end
  end
end
