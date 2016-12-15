class ProductsController < ApplicationController
  before_action :require_login

  def index
    @products = Product.where(purchased_by:nil)
  end

  def create
    product = Product.new(product_params)
    product.user = current_user

    if product.save()
      redirect_to dashboard_path(current_user)
    else
      flash[:errors] = product.errors.full_messages

      flash[:name] = product_params[:name]
      flash[:amount] = product_params[:amount]

      redirect_to dashboard_path(current_user)
    end
  end

  def update
    product  = Product.find(params[:id])

    product.purchased_by = current_user
    product.purchased_date = Date.today.to_s

    if product.save()
      redirect_to dashboard_path(current_user)
    else
      flash[:errors] = product.errors.full_messages
      redirect_to dashboard_path(current_user)
    end

  end

  def destroy
    product = Product.find(params[:id])
    product.destroy()

    redirect_to dashboard_path(current_user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :amount)
  end
end
