# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationLookupService, type: :service do
  describe '.find' do
    subject(:find) { described_class.find(query: query) }

    context 'with an empty query' do
      let(:query) { '' }

      it 'raises a NotFoundError' do
        expect { find }.to raise_error NotFoundError
      end
    end
  end
end
