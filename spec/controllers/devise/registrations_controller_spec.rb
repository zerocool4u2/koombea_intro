# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe Devise::RegistrationsController, 'Routes', type: :routing do
  it { is_expected.to route(:get, '/users/cancel').to(action: 'cancel') }
  it { is_expected.to route(:get, '/users/sign_up').to(action: 'new') }
  it { is_expected.to route(:get, '/users/edit').to(action: 'edit') }
  it { is_expected.to route(:patch, '/users').to(action: 'update') }
  it { is_expected.to route(:put, '/users').to(action: 'update') }
  it { is_expected.to route(:delete, '/users').to(action: 'destroy') }
  it { is_expected.to route(:post, '/users').to(action: 'create') }
end

RSpec.describe Devise::RegistrationsController, type: :controller do
end
