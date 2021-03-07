# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class ApplicationController < ActionController::Base
  include FlashHelper
  include PagyHelper
  include Pagy::Backend

  private
  protected
  def pagy_get_vars(collection, vars)
    super
    vars[:i18n_key] ||= "activerecord.models.#{ collection.model_name.i18n_key }"
    vars
  end
end
