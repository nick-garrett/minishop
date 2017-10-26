class InvoicesController < ApplicationController
  before_action :find_current_user
  before_action :find_user

  def index
    if @current_user == @user || @current_user&.admin?
      @invoices = @user.invoices
    elsif @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in to view invoices.'
    else
      redirect_to @current_user
      flash[:error] = 'You cannot view invoices for another user.'
    end
  end

  def show
    if @current_user == @user || @current_user&.admin?
      @invoice = @user.invoices.find_by(id: params[:id])
      unless @invoice
        redirect_to @current_user
        flash[:error] = "Invoice doesn't exist."
      end
    elsif @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in to view invoices.'
    else
      redirect_to @current_user
      flash[:error] = 'You cannot view invoices for another user.'
    end
  end

  def create
    if @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in as an admin to create an invoice.'
    elsif @current_user&.admin?
      @invoice = @user.invoices.create(invoice_params)
      redirect_to user_invoice_url(@user.id, @invoice) if @invoice.valid?
      # flash error if something failed?
    else
      redirect_to users_path(@current_user)
      flash[:error] = 'You must be logged in as an admin to create an invoice.'
    end
  end

  def new
    if @current_user.nil?
      redirect_to login_path
      flash[:error] = 'You must be logged in as an admin to create an invoice.'
    elsif !@current_user.admin?
      redirect_to users_path(@current_user)
      flash[:error] = 'You must be logged in as an admin to create an invoice.'
    end
  end

  def invoice_params
    params.require(:invoice).permit(:price, :usage)
  end

  def find_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
