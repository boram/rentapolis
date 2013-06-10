require 'spec_helper'

describe Api::SessionsController do
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
          post :create, session: { email: user.email, password: 'password' }
        end

        it 'sets the session' do
          expect(session[:user_id]).to eq(user.id)
        end

        it 'responds with the user id and email' do
          expect(response).to be_successful

          payload = JSON.parse(response.body)['user']
          expect(payload).to include('email' => user.email)
          expect(payload).to include('id' => user.id)
        end
      end

      context 'fail' do
        before do
          auth.should_receive(:authenticated?).and_return false
          post :create, session: { email: user.email, password: 'password' }
        end

        it 'does not set the session' do
          expect(session[:user_id]).to be_nil
        end

        it 'responds with an error message' do
          payload = JSON.parse(response.body)
          expect(payload).to include('message' => 'Invalid email or password')
        end
      end
    end
  end

  describe '#destroy' do
    before do
      session[:user_id] = 1
    end

    it 'clears the session' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
