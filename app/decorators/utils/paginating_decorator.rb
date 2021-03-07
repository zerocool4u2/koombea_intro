# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

# Collection delegation methods
class Utils::PaginatingDecorator < Draper::CollectionDecorator
  delegate :model_name, :attribute_name, :build, :to_model, :klass, :count
end
