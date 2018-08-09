require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { build :location }

  describe '#valid?' do
    subject { location.valid? }

    context 'when lat and lon are present' do
      before do
        location.lat = 1.0
        location.lon = 1.0
      end

      it { is_expected.to be true }
    end

    context 'when lat and lon are not present' do
      before do
        location.lat = nil
        location.lon = nil
      end

      it { is_expected.to be false }
    end

    context 'when lat and lon are non float values' do
      before do
        location.lat = 'not a float'
        location.lon = 'not a float'
      end

      it { is_expected.to be false }
    end
  end
end
