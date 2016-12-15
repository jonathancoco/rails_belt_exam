class PurchasedDate < ActiveRecord::Migration
  def change
    add_column :products, :purchased_date, :date 
  end
end
