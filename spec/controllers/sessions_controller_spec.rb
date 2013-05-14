require 'spec_helper'

describe SessionsController do
  describe '#create' do
    context 'omniauth sign in' do
      let(:user) { create :facebook_user }

      let(:auth_hash) do
        OmniAuth::AuthHash.new({
          provider: user.provider,
          uid: user.uid
        })
      end

      before do
        env = { 'omniauth.auth' => auth_hash }
        controller.should_receive(:env).any_number_of_times.and_return env
      end

      context 'success' do
        before do
          User.should_receive(:from_omniauth).and_return user
        end

        it 'sets the session' do
          get :create, provider: 'facebook'
          expect(session[:user_id]).to eq(user.id)
          expect(response).to redirect_to(root_url)
          expect(flash[:notice]).to_not be_blank
        end
      end

      context 'fail' do
        before do
          User.should_receive(:from_omniauth).and_return nil
        end

        it 'renders the template and displays an error' do
          get :create, provider: 'facebook'
          expect(session[:user_id]).to be_nil
          expect(response).to render_template(:new)
          expect(flash.now[:alert]).to_not be_blank
        end
      end
    end

    context 'form sign in' do
      let(:user) { create :user }
      let(:email) { user.email }
      let(:password) { user.password }

      context 'success' do
        before do
          User.should_receive(:authenticate).with(email, password).and_return user
        end

        it 'sets the session and redirects to root' do
          post :create, { email: email, password: password }
          expect(session[:user_id]).to eq(user.id)
          expect(response).to redirect_to(root_url)
          expect(flash[:notice]).to_not be_blank
        end
      end

      context 'fail' do
        before do
          User.should_receive(:authenticate).with(email, password).and_return nil
        end

        it 'sets the session and redirects to root' do
          post :create, { email: email, password: password }
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
