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

    context 'when a user is already logged in' do
      let(:users_count) { User.count }

      before do
        session[:user_id] = user.id
        post :create, params: { session: { email: email, password: password } }
      end

      it 'redirects to the users page' do
        expect(response).to redirect_to(user)
      end

      it 'does not increase the number of users' do
        expect(users_count).to eq(User.count)
      end
    end

    context 'when a user is not logged in' do
      let(:email) { user.email }
      let(:password) { 'password' }

      before do
        session[:user_id] = nil
        post :create, params: { session: { email: email, password: password } }
      end

      context 'when non-matching credentials are submitted' do
        let(:password) { 'invalid' }

        it 'redirects to login page' do
          expect(response).to redirect_to(login_url)
        end

        it 'adds error to flash' do
          expect(flash[:error]).to eq 'Login credentials did not match'
        end
      end

      context 'when matching credentials are submitted' do
        it 'redirects to user page' do
          expect(response).to redirect_to(user)
        end

        it 'does not add error to flash' do
          expect(flash[:error]).not_to eq 'Login credentials did not match'
        end

        it 'sets the current user' do
          expect(session[:user_id]).to eq user.id
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy
    end
  end
end
