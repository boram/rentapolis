require 'spec_helper'

describe User do
  describe '.from_omniauth' do
    context 'new user' do
      let(:auth_hash) do
        OmniAuth::AuthHash.new({
          provider: 'facebook',
          uid: '666',
          info: {
            name: 'Neil McCauley',
            email: 'neil@example.com',
            first_name: 'Neil',
            last_name: 'McCauley',
            image: "http://graph.facebook.com/666/picture?type=square",
            location: 'Bay Area'
          },
          credentials: {
            token: 'ASDF1234',
            expires_at: 2.weeks.from_now.to_i
          }
        })
      end

      it 'creates a new user and returns it' do
        user = User.where(provider: auth_hash.provider, uid: auth_hash.uid).first
        expect(user).to be_nil

        expect {
          user = User.from_omniauth(auth_hash)
        }.to change { User.count }.by 1

        expect(user.provider).to eq(auth_hash.provider)
        expect(user.uid).to eq(auth_hash.uid)
      end
    end

    context 'existing user' do
      let(:existing_user) { create :facebook_user }

      let(:auth_hash) do
        OmniAuth::AuthHash.new({
          provider: existing_user.provider,
          uid: existing_user.uid,
          info: {
            name: existing_user.name,
            email: existing_user.email,
            first_name: existing_user.first_name,
            last_name: existing_user.last_name,
            image: existing_user.avatar,
            location: existing_user.location
          },
          credentials: {
            token: 'ASDF1234',
            expires_at: 2.weeks.from_now.to_i
          }
        })
      end

      it 'returns the user' do
        user = User.from_omniauth(auth_hash)
        expect(user).to eq(existing_user)
      end
    end
  end
end
