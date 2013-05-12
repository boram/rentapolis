require 'spec_helper'

describe SessionsController do
  let(:user) { create :facebook_user }

  describe '#create' do
    before do
      User.should_receive(:from_omniauth).and_return(user)
    end

    it 'sets the session' do
      get :create, provider: 'facebook'
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe '#destroy' do
    before do
      session[:user_id] = user.id
    end

    it 'clears the session' do
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
