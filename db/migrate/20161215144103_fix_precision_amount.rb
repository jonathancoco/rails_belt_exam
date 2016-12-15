class FixPrecisionAmount < ActiveRecord::Migration
  def change
    change_column :products, :amount, :decimal, :precision => 10, :scale => 2, null:false
  end
end
