# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class CreditCardFormatValidator < ActiveModel::EachValidator
  VALID_CREDIT_CARDS = [:amex, :discover, :diners_club, :master_card, :visa, :maestro, :jcb]

  def validate_each(record, attribute, value)
    return if value.blank?

    CreditCardValidator::Validator.options[:allowed_card_types] = VALID_CREDIT_CARDS

    if CreditCardValidator::Validator.valid?(value)
      record.errors.add attribute, :invalid
    end
  end
end
