# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUserCommand do
  describe '.call' do
    subject(:call) { described_class.call(email, password) }

    before do
      allow(JwtService).to receive(:encode).and_return('token')
    end

    shared_examples 'unsuccessful request' do
      it 'is no successful call' do
        expect(call.success?).to be false
      end

      it 'returns a nil result' do
        expect(call.result).to be nil
      end

      it 'adds appropriate errors' do
        expect(call.errors.messages).to eq(base: ['Invalid credentials'])
      end
    end

    context 'with valid credentials' do
      let(:email) { 'test@example.com' }
      let(:password) { 'secret' }

      context 'with existing user' do
        before do
          create :user, email: email, password: password
        end

        it 'is a successful call' do
          expect(call.success?).to be true
        end

        it 'returns a User as result' do
          expect(call.result).to eq 'token'
        end

        it 'does not add any errors' do
          expect(call.errors).to be_empty
        end
      end

      context 'without existing user' do
        it_behaves_like 'unsuccessful request'
      end
    end

    context 'with missing credentials' do
      let(:email) { nil }
      let(:password) { nil }

      it_behaves_like 'unsuccessful request'
    end
  end
end
