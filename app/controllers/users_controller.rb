class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user ||= User.find_by(id: session[:user_id])
    redirect_to root_path unless @current_user&.admin?
  end

  def show
    @user = User.find(params[:id])
    @current_user ||= User.find_by(id: session[:user_id])
    if @user != @current_user
      redirect_to '/login'
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:error] = user.errors.full_messages.first
      redirect_to new_user_url
    end
  end

  def new
    @user = User.new
    @user.address = Address.new
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :password,
                                 :password_confirmation,
                                 :email,
                                 :icp,
                                 :validated,
                                 address_attributes: %i[line_1 line_2 line_3])
  end
end
