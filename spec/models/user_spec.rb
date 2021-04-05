# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_presence_of(:password) }
  end
end
