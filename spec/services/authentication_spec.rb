require 'spec_helper'

describe Authentication do
  describe '#authenticated?' do
    context 'with an omniauth hash' do
      context 'for a new user' do
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

        let(:auth) { Authentication.new({}, auth_hash) }

        it 'is true' do
          expect(auth.authenticated?).to be_true
        end

        it 'returns a new user' do
          expect(auth.user.provider).to eq(auth_hash.provider)
          expect(auth.user.uid).to eq(auth_hash.uid)
        end
      end

      context 'for an existing user' do
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

        let(:auth) { Authentication.new({}, auth_hash) }

        it 'is true' do
          expect(auth.authenticated?).to be_true
        end

        it 'returns the existing user' do
          expect(auth.user.provider).to eq(existing_user.provider)
          expect(auth.user.uid).to eq(existing_user.uid)
        end
      end

      context 'from password' do
        context 'for a non-existant user' do
          let(:auth) { Authentication.new }

          it 'is false' do
            expect(auth.authenticated?).to be_false
          end
        end

        context 'for an existing user' do
          let(:user) do
            create :user, email: 'foo@bar.com', password: 'heyo'
          end

          context 'with invalid credentials' do
            let(:auth) do
              Authentication.new email: 'boom@bam.com', password: 'wrongpassword'
            end

            it 'is false' do
              expect(auth.authenticated?).to be_false
            end
          end

          context 'with valid credentials' do
            let(:auth) do
              Authentication.new email: user.email, password: user.password
            end

            it 'is true' do
              expect(auth.authenticated?).to be_true
              expect(auth.user).to eq(user)
            end
          end
        end
      end
    end
  end
end
