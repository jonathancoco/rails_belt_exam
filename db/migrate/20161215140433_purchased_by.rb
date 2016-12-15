class PurchasedBy < ActiveRecord::Migration
  def change
    add_column :products, :purchased_by, :integer 
  end
end
