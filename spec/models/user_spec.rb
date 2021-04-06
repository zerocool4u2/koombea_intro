# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#to_s' do
    context 'on update' do
      subject { create(:user, email: 'test@example.com') }

      context 'with email' do
        it { expect(subject.to_s).to eq('test@example.com') }
      end

      context 'with email nil' do
        before { subject.email = nil }
        it { expect(subject.to_s).to eq('test@example.com') }
      end
    end
  end
end
