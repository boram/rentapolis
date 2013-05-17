require 'spec_helper'

describe SessionsController do
  describe '#create' do
    context 'omniauth sign in' do
      let(:user) { create :user }
      let(:auth) { mock('auth', user: user) }

      before do
        Authentication.should_receive(:new).and_return auth
      end

      context 'success' do
        before do
          auth.should_receive(:authenticated?).and_return true
        end

        it 'sets the session' do
          get :create
          expect(session[:user_id]).to eq(user.id)
          expect(response).to redirect_to(root_url)
          expect(flash[:notice]).to_not be_blank
        end
      end

      context 'fail' do
        before do
          auth.should_receive(:authenticated?).and_return false
        end

        it 'renders the template and displays an error' do
          get :create, provider: 'facebook'
          expect(session[:user_id]).to be_nil
          expect(response).to render_template(:new)
          expect(flash.now[:alert]).to_not be_blank
        end
      end
    end
  end

  describe '#destroy' do
    before do
      session[:user_id] = 1
    end

    it 'clears the session' do
      get :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_url)
    end
  end
end
