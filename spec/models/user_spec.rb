require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe '#valid?' do
    subject { user.valid? }

    context 'when email is present' do
      before { user.update(email: 'test@example.com') }

      it { is_expected.to be true }
    end

    context 'when email is not present' do
      before { user.update(email: nil) }

      it { is_expected.to be false }
    end

    context 'when password is present' do
      before { user.update(password: 'secure') }

      it { is_expected.to be true }
    end

    context 'when password is not present' do
      before { user.update(password: nil) }

      it { is_expected.to be_falsy }
    end
  end
end
