# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeocodeLocationCommand do
  describe '.call' do
    subject(:call) { described_class.call(query) }

    shared_examples 'unsuccessful request' do
      it 'is no successful call' do
        expect(call.success?).to be false
      end

      it 'returns a nil result' do
        expect(call.result).to be nil
      end
    end

    context 'with valid query' do
      let(:query) { 'example street' }

      it 'is a successful call' do
        expect(call.success?).to be true
      end

      it 'returns a Location as result' do
        expect(call.result).to be_kind_of Location
      end

      it 'does not add any errors' do
        expect(call.errors).to be_empty
      end
    end

    context 'with empty query' do
      let(:query) { '' }

      it_behaves_like 'unsuccessful request'

      it 'adds the appropriate error' do
        expect(call.errors.messages).to eq(location: ['Invalid query'])
      end
    end

    context 'with unknown location' do
      let(:query) { 'nonsense gibberish' }

      it_behaves_like 'unsuccessful request'

      it 'adds the appropriate error' do
        expect(call.errors.messages).to eq(location: ['Location not found'])
      end
    end

    context 'when Geocoding service is unreachable' do
      let(:query) { 'somewhat relevant' }

      before do
        allow(Geocoder).to receive(:search)
          .and_raise Geocoder::ServiceUnavailable
      end

      it_behaves_like 'unsuccessful request'

      it 'adds the appropriate error' do
        expect(call.errors.messages)
          .to eq(location: ['Geocoder::ServiceUnavailable'])
      end
    end
  end
end
