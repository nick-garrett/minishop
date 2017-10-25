class UsersController < ApplicationController
  before_action :find_current_user, only: %i[index show new update destroy]
  before_action :find_user, only: %i[show create update destroy]

  def index
    @users = User.all

    redirect_to root_path unless @current_user&.admin?
  end

  def show
    if @current_user&.admin?
      redirect_to users_path
    elsif !@current_user
      redirect_to login_path
      flash[:error] = 'You must be logged in to view this page'
    elsif @user != @current_user
      redirect_to @current_user
      flash[:error] = 'You cannot view another users profile'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.first
      redirect_to new_user_url
    end
  end

  def new
    if @current_user
      redirect_to @current_user
      flash[:error] = 'You must logout before you can login again'
    else
      @user = User.new
      @user.address = Address.new
    end
  end

  def update
    if @current_user&.admin?
      @user.update(user_params)
      redirect_to users_path
    else
      redirect_to root_path
      flash[:error] = 'You must be an admin to update a user'
    end
  end

  def destroy
    # admin can't destroy themselves
    if @current_user&.admin?
      @user.destroy unless @user.admin?
      redirect_to users_path
    else
      redirect_to root_path
      flash[:error] = 'You must be an admin to delete a user'
    end
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

  def find_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
