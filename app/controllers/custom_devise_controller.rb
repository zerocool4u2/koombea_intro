# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

class CustomDeviseController < ApplicationController
  before_action :configure_permitted_parameters

  protected
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource)
    new_session_path(resource_name)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sing_in, keys: [:remember_me])
  end
end
