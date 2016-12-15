class UsersController < ApplicationController

  def create
    user  = User.new(user_params)

    if user.save()
      session[:user_id] = user.id

      ##########################################################################
      # *** modify this and point it to the appropriate path after  login  ****#
      ##########################################################################
      redirect_to products_path
    else
      flash[:login_error] = "registration"
      flash[:errors] = user.errors.full_messages

      flash[:name] = user_params[:name]
      flash[:email] = user_params[:email]
      flash[:description] = user_params[:description]

      redirect_to new_session_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :description,  :password, :password_confirmation)
  end

end
