class SessionsController < ApplicationController
  def new
    redirect_to User.find(session[:user_id]) if session[:user_id]
  end

  def create
    if session[:user_id]
      redirect_to User.find(session[:user_id])
      return
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:error] = 'Login credentials did not match'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to '/login'
  end
end
