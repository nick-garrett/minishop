class UsersController < ApplicationController
  before_action :find_current_user, only: %i[index show new update destroy]
  before_action :find_user, only: %i[show create update destroy]
  before_action :check_permission, only: %i[index update destroy]

  def index
    @users = User.all
  end

  def show
    if !@current_user
      redirect_to login_path
      flash[:error] = 'You must be logged in'
    elsif @user != @current_user
      redirect_to @current_user
      flash[:error] = 'You cannot view another users profile'
    end
  end

  def create
    @user = User.new(create_user_params) # don't permit validated in user params
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      # TODO: form helper errors
      # redirect_to new_user_url
      respond_to do |format|
        format.js
      end
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
    flash[:error] = 'Failed to update user' unless @user.update_attributes(user_validated_param)
    redirect_to users_path
  end

  # TODO: remove destroy
  def destroy
    @user.destroy unless @user.admin?
    redirect_to users_path
  end

  def create_user_params
    params.require(:user).permit(:first_name,
     :last_name,
     :password,
     :password_confirmation,
     :email,
     :icp,
     address_attributes: %i[line_1 line_2 line_3])
  end

  def user_validated_param
    params.require(:user).permit(:validated)
  end

  def check_permission
    return if @current_user&.admin?
    redirect_to root_path
    flash[:error] = 'You must be an admin'
  end

  def find_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
