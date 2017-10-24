require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  fixtures :users
  fixtures :invoices

  let(:user) { users(:user) }
  let(:current_user) { users(:user) }

  describe 'GET #index' do
    context 'when the wrong user is logged in' do
      let(:current_user) { users(:user_two) }

      before do
        session[:user_id] = current_user.id
        get :index, params: { user_id: user.id }
      end

      it 'redirects to current user' do
        expect(response).to redirect_to current_user
      end

      it 'has correct flash message' do
        expect(flash[:error]).to include 'You cannot view the invoices for another user.'
      end
    end

    context 'when the correct user is logged in' do
      let(:current_user) { users(:user) }

      before do
        session[:user_id] = users(:user).id
        get :index, params: { user_id: user.id }
      end

      it 'does not redirect' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when the wrong user is logged in' do
      let(:current_user) { users(:user_two) }

      before do
        session[:user_id] = current_user.id
        get :show, params: { user_id: user.id, id: 1 }
      end

      it 'redirects to current user' do
        pending 'pending test'
      end

      it 'has correct flash message' do
        pending 'pending test'
      end
    end

    context 'when the correct user is logged in' do
      let(:current_user) { users(:user) }

      context 'when the invoice exists' do
        let(:invoice) { invoices(:first) }

        before do
          session[:user_id] = current_user.id
          get :show, params: { user_id: user.id, id: invoice.id }
        end

        it 'does not redirect' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when the invoice does not exist' do
        before do
          session[:user_id] = current_user.id
          get :show, params: { user_id: user.id, id: 100 }
        end

        it 'redirects to the current user' do
          pending 'pending test'
        end

        it 'has appropriate error' do
          pending 'pending test'
        end
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'GET #new' do

  end

  describe '' do

  end
end
