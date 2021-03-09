# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved
#
class ContactDecorator < ApplicationDecorator
  def credit_card_number_filtered
    '*' * (credit_card_number.length - 4) + credit_card_number.last(4)
  end
end
