class InvoicesController < ApplicationController
  before_action :find_current_user
  before_action :find_user

  def index
    if @current_user&.id == @user&.id

    elsif @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in to view invoices.'
    else
      redirect_to @current_user
      flash[:error] = 'You cannot view invoices for another user.'
    end
  end

  def show
    if @current_user&.id == @user&.id
      
    elsif @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in to view invoices.'
    else
      redirect_to @current_user
      flash[:error] = 'You cannot view invoices for another user.'
    end
  end

  def create
  end

  def new
  end

  def find_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
