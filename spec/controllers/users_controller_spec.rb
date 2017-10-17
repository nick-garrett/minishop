require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  fixtures :users
  fixtures :addresses

  describe 'GET #index' do
    context 'when the user is logged in as an admin' do
      before do
        session[:user_id] = users(:admin).id
        @current_user = nil
        get :index
      end

      it 'loads the index page' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in as an admin' do
      before do
        session[:user_id] = users(:user).id
        @current_user = nil
        get :index
      end

      it 'redirects to the root path' do
        expect(response).not_to have_http_status(:ok)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #show' do
    context 'when the user is logged in as a user' do
      before do
        session[:user_id] = users(:user).id
        @current_user = nil
        get :show
      end

      it 'shows the users info page' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in' do
      before do
        session[:user_id] = nil
        @current_user = nil
        get :show
      end

      it 'redirects to the login page' do
        expect(response).to rediect_to(login_url)
      end
    end

    context 'when the user is logged in as an admin' do
      before do
        session[:user_id] = users(:admin).id
        @current_user = nil
        get :show
      end

      it 'redirects to the users page' do
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'GET #new' do

  end

  describe 'PATCH #update' do

  end

  describe 'DELETE #destroy' do

  end

end
