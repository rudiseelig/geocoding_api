# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtService, type: :service do
  subject { described_class }

  let(:payload) { { 'one' => 'two' } }
  let(:token) do
    'eyJhbGciOiJIUzI1NiJ9.eyJvbmUiOiJ0d28ifQ.' \
    'I-XKD3fqbl0srIHfRcNEbn0GZd3TO49_rQg2xSPoVKA'
  end

  describe '.encode' do
    it { expect(subject.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    it { expect(subject.decode(token)).to eq(payload) }
  end
end
