# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved
#
class CsvFileDecorator < ApplicationDecorator
  decorates_association :contacts
  def filename
    file.filename.to_s
  end
end
