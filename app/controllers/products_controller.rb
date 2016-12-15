class ProductsController < ApplicationController
  before_action :require_login

  def index
    @products = Product.where(purchased_by:nil)
  end

  def create
    product = Product.new(product_params)
    product.user = current_user

    if product.save()
      redirect_to products_dashboard_path
    else
      flash[:errors] = product.errors.full_messages

      flash[:name] = product_params[:name]
      flash[:amount] = product_params[:amount]

      redirect_to products_dashboard_path
    end
  end

  def update
    product  = Product.find(params[:id])

    product.purchased_by = current_user
    product.purchased_date = Date.today.to_s

    if product.save()
      redirect_to products_dashboard_path
    else
      flash[:errors] = product.errors.full_messages
      redirect_to products_dashboard_path
    end

  end

  def destroy
    product = Product.find(params[:id])
    product.destroy()

    redirect_to products_dashboard_path
  end

  def dashboard
    @my_products = Product.where(user:current_user).where(purchased_by:nil)
    @my_purchased_products = Product.where(purchased_by:current_user)

    @total_purchases = 0
    @my_purchased_products.each do |product|
      @total_purchases = @total_purchases + product.amount
    end

    @my_sold_products = Product.where(user:current_user).where.not(purchased_by:nil)

    @total_sold = 0
    @my_sold_products.each do |product|
      @total_sold = @total_sold + product.amount
    end

  end

  private
  def product_params
    params.require(:product).permit(:name, :amount)
  end
end
