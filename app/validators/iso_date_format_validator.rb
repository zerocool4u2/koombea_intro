# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class IsoDateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    begin
      Date.parse(value, '%F')
    rescue ArgumentError
      record.errors.add attribute, :invalid
    end
  end
end
