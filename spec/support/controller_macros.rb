# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end
end
