# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecodeAuthenticationCommand do
  describe '.call' do
    subject(:call) { described_class.call(headers) }

    shared_examples 'unsuccessful request' do
      it 'is no successful call' do
        expect(call.success?).to be false
      end

      it 'returns a nil result' do
        expect(call.result).to be nil
      end
    end

    context 'with valid Authorization header' do
      let(:headers) { { 'Authorization' => 'Bearer token' } }
      let(:user) { create :user }
      let(:decoded_token) { { 'user_id' => user.id } }

      before do
        allow(JwtService).to receive(:decode).and_return(decoded_token)
      end

      it 'calls JwsService to decode the token' do
        expect(JwtService).to receive(:decode).with('token')
        call
      end

      it 'is a successful call' do
        expect(call.success?).to be true
      end

      it 'returns a User as result' do
        expect(call.result).to eq user
      end

      it 'does not add any errors' do
        expect(call.errors).to be_empty
      end
    end

    context 'when Authorization header is not present' do
      let(:headers) { {} }

      it_behaves_like 'unsuccessful request'

      it 'adds appropriate errors' do
        expect(call.errors.messages).to eq(token: ['Token missing'])
      end
    end
  end
end
