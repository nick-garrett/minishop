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
        get :show, params: { id: session[:user_id] }
      end

      it 'shows the users info page' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is not logged in' do
      before do
        session[:user_id] = nil
        @current_user = nil
        get :show, params: { id: 1 }
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to(login_url)
      end
    end

    context 'when the user is logged in as an admin' do
      before do
        session[:user_id] = users(:admin).id
        @current_user = nil
        get :show, params: { id: session[:user_id] }
      end

      it 'redirects to the users page' do
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe 'POST #create' do
    context 'when the details for a new user are all valid' do
      before do
        post :create, params: { user: { email: 'test@test.test',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        first_name:  'test',
                                        last_name: 'test',
                                        icp: '123123123',
                                        address_attributes: { line_1: 'a',
                                                              line_2: 'a',
                                                              line_3: 'a' } } }
      end

      it 'redirects to show' do
        expect(response).to redirect_to(assigns[:user])
      end
    end

    context 'when the details for a new user are incorrect' do
      before do
        post :create, params: { user: { email: 'test@',
                                        password: 'password',
                                        password_confirmation: 'password',
                                        first_name:  'test',
                                        last_name: 'test',
                                        icp: '123123123',
                                        address_attributes: { line_1: 'a',
                                                              line_2: 'a',
                                                              line_3: 'a' } } }
      end

      it 'redirects to the sign up page' do
        expect(response).to redirect_to(new_user_url)
      end

      it 'saves an appropriate error' do
        expect(flash[:error]).not_to be_empty
      end
    end
  end

  describe 'GET #new' do
    context 'when user is already logged in' do
      before do
        session[:user_id] = users(:user).id
        get :new
      end

      it 'redirects to the current_user' do
        expect(response).to redirect_to(assigns[:current_user])
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

  describe 'PATCH #update' do
    context 'when a non-admin user tries to update a user' do
      let(:user) { users(:user) }
      before do
        session[:user_id] = nil
        patch :update, params: { id: user.id, user: { validated: true } }
      end

      it 'does not update the user' do
        expect(User.find(user.id).validated).to eq false
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_url
      end
    end

    context 'when an admin tries to update a user' do
      let(:user) { users(:user) }

      before do
        session[:user_id] = users(:admin).id
        patch :update, params: { id: user.id, user: { validated: true } }
      end

      it 'updates the user' do
        expect(User.find(user.id).validated).to eq true
      end

      it 'redirects to users path' do
        expect(response).to redirect_to users_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when a non-admin user tries to delete a user' do
      let(:user) { users(:user) }
      before do
        session[:user_id] = nil
        delete :destroy, params: { id: user.id }
      end

      it 'does not delete the user' do
        expect(User.find_by(id: user.id)).to be_truthy
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_url
      end
    end

    context 'when an admin tries to delete a user' do
      let(:user) { users(:user) }

      before do
        session[:user_id] = users(:admin).id
        delete :destroy, params: { id: user.id }
      end

      it 'deletes the user' do
        expect(User.find_by(id: user.id)).to be_falsy
      end

      it 'redirects to users path' do
        expect(response).to redirect_to users_path
      end
    end
  end
end
