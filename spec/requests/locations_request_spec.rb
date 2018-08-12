# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations request', type: :request do
  shared_examples 'correct content_type' do
    it 'responds with correct content type' do
      get_locations
      expect(response.content_type).to eq 'application/json'
    end
  end

  let(:headers) { { 'Authorization' => 'Bearer secret' } }
  let(:current_user) { create :user }
  let(:location) { nil }

  before do
    decode_double = instance_double(DecodeAuthenticationCommand,
                                    result: current_user)
    location_double = instance_double(DecodeAuthenticationCommand,
                                      result: location,
                                      success?: success)
    allow(DecodeAuthenticationCommand)
      .to receive(:call)
      .and_return(decode_double)
    allow(GeocodeLocationCommand)
      .to receive(:call)
      .and_return(location_double)
  end

  describe 'GET locations' do
    subject(:get_locations) do
      get('/api/v1/locations', params: params, headers: headers)
    end

    let(:location) { create :location, lat: lat, lon: lon }
    let(:success) { true }

    let(:lat) { 1.5 }
    let(:lon) { 1.5 }

    context 'with correct query params' do
      let(:params) { { query: query } }
      let(:query) { 'asd' }

      it 'accesses a command to geocode the location' do
        expect(GeocodeLocationCommand).to receive(:call).with(query)
        get_locations
      end

      it 'responds with coordinates of the location' do
        get_locations
        expected_response = { location: { lat: lat, lon: lon } }.to_json
        expect(response.body).to eq expected_response
      end

      it_behaves_like 'correct content_type'
    end

    context 'when query params are missing' do
      let(:params) { {} }

      it 'responds with an appropriate status code' do
        get_locations
        expect(response.status).to eq 400
      end

      it 'responds with an appropriate error' do
        get_locations
        expect(response.body).to match 'Parameter Missing'
      end

      it_behaves_like 'correct content_type'
    end
  end
end
