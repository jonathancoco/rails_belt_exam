class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.try(:authenticate, params[:password])
      session[:user_id] = user.id


      ##########################################################################
      # *** modify this and point it to the appropriate path after  login  ****#
      ##########################################################################
      redirect_to products_path
    else
      flash[:login_error] = "login"
      flash[:errors] = []

      flash[:login_email] = params[:email]

      if user
        flash[:errors].insert(-1, "Invalid Password")
      else
        flash[:errors].insert(-1, "User not found")
      end
      redirect_to new_session_path
    end
  end

  def new
    if (flash[:name] == nil &&
      flash[:login_email] == nil &&
      flash[:email] == nil)

      flash[:login_email] = ""
      flash[:name] = ""
      flash[:email] = ""
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
