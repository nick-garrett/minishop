class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create!(user_params)
    redirect_to user if user.save
  end

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :icp)#, :address_attributes[:line_1, :line_2, :line_3])
  end

  def address_params

  end
end
