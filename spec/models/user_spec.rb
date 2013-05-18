require 'spec_helper'

describe User do
  context 'enabled validations' do
    describe 'email' do
      context 'when blank' do
        let(:user) { User.new }

        it 'has the presence error' do
          expect(user.errors_on(:email)).to include("can't be blank")
        end

        it 'has the format error' do
          expect(user.errors_on(:email)).to include('is invalid')
        end
      end

      context 'when invalid' do
        let(:user) { User.new email: 'asdf' }

        it 'has the format error' do
          expect(user.errors_on(:email)).to include('is invalid')
        end
      end

      context 'when valid' do
        let(:user) { User.new email: 'foo@bar.com' }

        it 'has no errors' do
          expect(user.errors_on(:email)).to be_blank
        end
      end
    end

    describe 'password' do
      context 'when blank' do
        let(:user) { User.new }

        it 'has the presence error' do
          expect(user.errors_on(:password)).to include("can't be blank")
        end
      end

      context 'when too short' do
        let(:user) { User.new password: 'aaa' }

        it 'has the length error' do
          expect(user.errors_on(:password)).to include('is too short (minimum is 4 characters)')
        end
      end

      context 'when valid' do
        let(:user) { User.new password: 'aaaa' }

        it 'has the length error' do
          expect(user.errors_on(:password)).to be_blank
        end
      end
    end

    describe '#require_validations?' do
      let(:user) { User.new }

      it 'is true' do
        expect(user.require_validations?).to be_true
      end
    end
  end

  context 'disabled validations' do
    let(:user) { User.new }

    before { user.disable_validations! }

    it 'is valid' do
      expect(user).to be_valid
    end

    describe '#require_validations?' do
      it 'is false' do
        expect(user.require_validations?).to be_false
      end
    end
  end

  describe '#encrypt_password' do
    let(:user) { build :user }

    let(:decrypted_password) do
      BCrypt::Password.new(user.password_digest)
    end

    before { user.save }

    it 'encrypts the password' do
      expect(decrypted_password).to eq(user.password)
    end
  end
end
