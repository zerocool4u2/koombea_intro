# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    subject { build(:contact) }

    it { is_expected.to belong_to(:csv_file).optional }

    context 'without flag skip_validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:birthday) }
      it { is_expected.to validate_presence_of(:phone) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:credit_card_number) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    context 'with flag skip_validations' do
      subject { build(:contact, skip_validations: true) }

      it { is_expected.to_not validate_presence_of(:name) }
      it { is_expected.to_not validate_presence_of(:birthday) }
      it { is_expected.to_not validate_presence_of(:phone) }
      it { is_expected.to_not validate_presence_of(:address) }
      it { is_expected.to_not validate_presence_of(:credit_card_number) }
      it { is_expected.to_not validate_presence_of(:email) }
      it { is_expected.to_not validate_uniqueness_of(:email) }
    end

    context 'before_validation' do
      describe '#set_franchise' do
        it 'should load franchise when credit_card_number is present' do
          subject.valid?
          expect(subject.franchise).to be_present
        end

        it 'should set franchise to nil when credit_card_number is nil' do
          subject.credit_card_number = nil
          subject.valid?
          expect(subject.franchise).to be_nil
        end

        it 'should set franchise to nil when credit_card_number is invalid' do
          subject.credit_card_number = 'ABCDE'
          subject.valid?
          expect(subject.franchise).to be_nil
        end
      end
    end

    describe '#check_active' do
      context 'individual creation' do
        context 'valid contact' do
          subject { create(:contact) }

          it { is_expected.to be_active }
        end

        context 'invalid contact' do
          subject { Contact.create }

          it { is_expected.to_not be_active }
        end
      end

      context 'mass creation' do
        context 'valid contact' do
          subject { create(:contact, parsing_from_csv: true) }

          it { is_expected.to_not be_active }
        end

        context 'invalid contact' do
          subject { Contact.create(parsing_from_csv: true) }

          it { is_expected.to_not be_active }
        end
      end
    end
  end

  describe 'scopes' do
    describe '.active' do
      it 'includes only active contacts' do
        active_contact = create(:contact, parsing_from_csv: true, active: true)
        expect(Contact.active).to include(active_contact)
      end
    end

    describe '.inactive' do
      it 'includes only inactive contacts' do
        inactive_contact = create(:contact, parsing_from_csv: true, active: false)
        expect(Contact.inactive).to include(inactive_contact)
      end
    end
  end

   describe '#to_s' do
    context 'on update' do
      subject { create(:contact, name: 'Example User') }

      context 'with name' do
        it { expect(subject.to_s).to eq('Example User') }
      end

      context 'with name nil' do
        before { subject.name = nil }
        it { expect(subject.to_s).to eq('Example User') }
      end
    end
  end
end
