# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class CsvFile < ApplicationRecord
  require 'csv'

  has_one_attached :file
  attribute :headers, :boolean
  attribute :headers_format, :boolean

  attribute :name_column, :integer
  attribute :birthday_column, :integer
  attribute :phone_column, :integer
  attribute :address_column, :integer
  attribute :credit_card_number_column, :integer
  attribute :email_column, :integer

  enum status: [:waiting, :processing, :fail, :done]
  translate_enum :status

  has_many :contacts, inverse_of: :csv_file
  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :file, content_type: ['text/csv', 'application/vnd.ms-excel']
  validates :name_column, presence: true, if: -> { not headers_format? }
  validates :email_column, presence: true, if: -> { not headers_format? }
  validates :birthday_column, presence: true, if: -> { not headers_format? }
  validates :phone_column, presence: true, if: -> { not headers_format? }
  validates :address_column, presence: true, if: -> { not headers_format? }
  validates :credit_card_number_column,  presence: true, if: -> { not headers_format? }

  def to_s
    "#{ self.singularize } #{ id }"
  end

  # TODO check status and write cases
  def parse_contacts
    case status
    when :waiting
    when :processing
    when :fail
    when :done
    else
      if headers? and headers_format?
        name = :nombre
        birthday = :fecha_de_nacimiento
        phone = :telefono
        address = :direccion
        credit_card_number = :tarjeta_de_credito
        email = :email
      else
        name = name_column - 1
        birthday = birthday_column - 1
        phone = phone_column - 1
        address = address_column - 1
        credit_card_number = credit_card_number_column - 1
        email = email_column - 1
      end

      CSV.parse(file.download, headers: headers, header_converters: :symbol) do |row|
        contact = self.contacts.build(
          name: row[name],
          birthday: row[birthday],
          phone: row[phone],
          address: row[address],
          credit_card_number: row[credit_card_number],
          email: row[email]
        )
        if contact.valid?
          contact.active = true
          contact.save
        end
      end

      if self.valid?
        self.status = :done
      else
        self.status = :fail
      end
    end

    return self
  end
end

# == Schema Information
# Schema version: 20210307100046
#
# Table name: csv_files
#
#  id         :integer          not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
