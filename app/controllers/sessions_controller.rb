class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      @current_user = user
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
