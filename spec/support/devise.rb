# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require_relative './controller_macros'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.extend ControllerMacros, type: :controller
end
