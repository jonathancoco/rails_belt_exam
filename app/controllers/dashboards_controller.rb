class DashboardsController < ApplicationController
  before_action :require_login
  
  def show

    user = User.find(params[:id])

    @my_products = Product.where(user:user).where(purchased_by:nil)
    @my_purchased_products = Product.where(purchased_by:user)

    @total_purchases = 0
    @my_purchased_products.each do |product|
      @total_purchases = @total_purchases + product.amount
    end

    @my_sold_products = Product.where(user:user).where.not(purchased_by:nil)

    @total_sold = 0
    @my_sold_products.each do |product|
      @total_sold = @total_sold + product.amount
    end
  end
end
