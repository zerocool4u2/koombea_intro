# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'

RSpec.describe Devise::SessionsController, 'Routes', type: :routing do
  it { is_expected.to route(:get, '/users/sign_in').to(action: 'new') }
  it { is_expected.to route(:post, '/users/sign_in').to(action: 'create') }
  it { is_expected.to route(:delete, '/users/sign_out').to(action: 'destroy') }
end

RSpec.describe Devise::SessionsController, type: :controller do
  let(:user) { create(:user) }

  it 'signs user in and out' do
    sign_in user
    expect(controller.current_user).to eq(user)

    sign_out user
    expect(controller.current_user).to be_nil
  end

  it { expect(controller.send :after_sign_in_path_for, user).to eq root_path }
end
