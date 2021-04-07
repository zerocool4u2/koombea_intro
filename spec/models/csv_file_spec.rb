# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe CsvFile, type: :model do
  describe 'validations' do
    it { is_expected.to have_one_attached(:file) }

    it { is_expected.to define_enum_for(:status).with_values([:waiting, :processing, :fail, :done]) }

    it { is_expected.to have_many(:contacts) }
    it { is_expected.to accept_nested_attributes_for(:contacts) }

    it { is_expected.to validate_presence_of(:file) }

    describe 'with formatted headers' do
      subject { build(:csv_file, headers: true, headers_format: true) }
    end

    describe 'with unformatted headers' do
      subject { build(:csv_file, headers: true, headers_format: false) }

      it { is_expected.to validate_presence_of(:name_column) }

      it { is_expected.to validate_presence_of(:birthday_column) }

      it { is_expected.to validate_presence_of(:phone_column) }

      it { is_expected.to validate_presence_of(:address_column) }

      it { is_expected.to validate_presence_of(:credit_card_number_column) }

      it { is_expected.to validate_presence_of(:email_column) }
    end

    describe 'without headers' do
      subject { build(:csv_file, headers: false, headers_format: false) }

      it { is_expected.to validate_presence_of(:name_column) }

      it { is_expected.to validate_presence_of(:birthday_column) }

      it { is_expected.to validate_presence_of(:phone_column) }

      it { is_expected.to validate_presence_of(:address_column) }

      it { is_expected.to validate_presence_of(:credit_card_number_column) }

      it { is_expected.to validate_presence_of(:email_column) }
    end
  end

  describe '#parse_contacts' do
    context 'on create' do
      it 'should initialize with status waiting'
      it 'should pass from waiting to processing'

      it 'should call parse_csv_file and pass from processing to fail or done'

      context 'done' do
        it 'should have all valid contacts'
        it 'should end with status done'
        it 'should validate itself and contacts'
        it 'should do nothing if all valid'
        it 'should pass to fail if at least one fail'
      end

      context 'fail' do
        it 'should have at least one invalid contact'
        it 'should end with status fail'
        it 'should validate itself and contacts'
        it 'should do nothing if at least one fail'
        it 'should pass to done if all valid'
      end
    end
  end
end
