require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  fixtures :users
  fixtures :addresses

  let(:user) { users(:user) }

  describe 'GET #new' do
    context 'when user is already logged in' do
      before do
        session[:user_id] = user.id
        get :new
      end

      it 'redirects to logged in user page' do
        expect(response).to redirect_to(user)
      end
    end

    context 'when user is not logged in' do
      before do
        session[:user_id] = nil
        get :new
      end

      it 'does not redirect' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    let(:email) { user.email }
    let(:password) { 'password' }

    before do
      post :create, params: { session: { email: email, password: password } }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy
    end
  end
end
