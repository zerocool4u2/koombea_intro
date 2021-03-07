# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

class ApplicationDecorator < Draper::Decorator
  include Draper::LazyHelpers
  include ContentHelper

  delegate_all

  # Collection delegation methods
  def self.collection_decorator_class
    Utils::PaginatingDecorator
  end
end
