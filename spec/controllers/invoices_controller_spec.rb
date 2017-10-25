require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  fixtures :users
  fixtures :invoices

  let(:user) { users(:user) }
  let(:current_user) { users(:user) }
  let(:invoice) { invoices(:first) }

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
        expect(flash[:error]).to include 'You cannot view invoices for another user.'
      end
    end

    context 'when the correct user is logged in' do
      let(:current_user) { users(:user) }

      before do
        session[:user_id] = current_user.id
        get :index, params: { user_id: user.id }
      end

      it 'does not redirect' do
        expect(response).to have_http_status :ok
      end
    end

    context 'when no user is logged in' do
      before do
        session[:user_id] = nil
        get :index, params: { user_id: user.id }
      end

      it 'redirects to login page' do
        expect(response).to redirect_to login_path
      end

      it 'has appropriate error message' do
        expect(flash[:error]).to include 'You must be logged in to view invoices.'
      end
    end
  end

  describe 'GET #show' do
    context 'when the wrong user is logged in' do
      let(:current_user) { users(:user_two) }

      before do
        session[:user_id] = current_user.id
        get :show, params: { user_id: user.id, id: invoice.id }
      end

      it 'redirects to current user' do
        expect(response).to redirect_to current_user
      end

      it 'has correct flash message' do
        expect(flash[:error]).to include 'You cannot view invoices for another user.'
      end
    end

    context 'when no user is logged in' do
      before do
        session[:user_id] = nil
        get :show, params: { user_id: user.id, id: invoice.id }
      end

      it 'redirects to login page' do
        expect(response).to redirect_to login_path
      end

      it 'has appropriate error message' do
        expect(flash[:error]).to include 'You must be logged in to view invoices.'
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
          expect(response).to have_http_status :ok
        end
      end

      context 'when the invoice does not exist' do
        before do
          session[:user_id] = current_user.id
          get :show, params: { user_id: user.id, id: 100 }
        end

        it 'redirects to the current user' do
          expect(response).to redirect_to current_user
        end

        it 'has appropriate error' do
          expect(flash[:error]).to include "Invoice doesn't exist."
        end
      end
    end
  end

  describe 'POST #create' do
    before do
      session[:user_id] = current_user&.id
      post :create, params: { user_id: user.id }
    end

    context 'when the wrong user is logged in' do
      let(:current_user) { users(:user_two) }

      it 'redirects to the current user' do
        expect(response).to redirect_to users_path(current_user)
      end

      it 'has appropriate error' do
        expect(flash[:error]).to include 'You cannot create an invoice for another user.'
      end
    end

    context 'when no user is logged in' do
      let(:current_user) { nil }

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end

      it 'has appropriate error' do
        expect(flash[:error]).to include 'You must be logged in to create an invoice.'
      end
    end

    context 'when the correct user is logged in' do
      let(:current_user) { users(:user) }

      pending
      it 'does not redirect' do
        expect(response).to have_http_status :ok
      end
    end
  end

  describe 'GET #new' do
    before do
      session[:user_id] = current_user&.id
      get :new, params: { user_id: user.id }
    end

    context 'when the wrong user is logged in' do
      let(:current_user) { users(:user_two) }

      it 'redirects to the current user' do
        expect(response).to redirect_to users_path(current_user)
      end

      it 'has appropriate error' do
        expect(flash[:error]).to include 'You cannot create an invoice for another user.'
      end
    end

    context 'when no user is logged in' do
      let(:current_user) { nil }

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end

      it 'has appropriate error' do
        expect(flash[:error]).to include 'You must be logged in to create an invoice.'
      end
    end

    context 'when the correct user is logged in' do
      let(:current_user) { users(:user) }

      it 'does not redirect' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
