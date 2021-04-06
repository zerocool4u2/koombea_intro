# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    subject { build(:contact) }

    it { is_expected.to belong_to(:csv_file).optional }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_presence_of(:birthday) }

    it { is_expected.to validate_presence_of(:phone) }

    it { is_expected.to validate_presence_of(:address) }

    it { is_expected.to validate_presence_of(:credit_card_number) }

    describe '#franchise' do
      context '.before_validation' do
        it 'should load franchise when credit_card_number is present' do
          subject.valid?
          expect(subject.franchise).to be_present
        end

        it 'should set franchise to nil when credit_card_number is nil' do
          subject.credit_card_number = nil
          subject.valid?
          expect(subject.franchise).to be_nil
        end
      end
    end
  end
end
