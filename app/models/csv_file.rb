# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class CsvFile < ApplicationRecord
  require 'csv'

  has_one_attached :file

  enum status: [:waiting, :processing, :fail, :done]
  translate_enum :status

  has_many :contacts, inverse_of: :csv_file, dependent: :destroy
  accepts_nested_attributes_for :contacts, allow_destroy: true
  validates_associated :contacts

  validates :file, presence: true, content_type: ['text/csv', 'application/vnd.ms-excel']
  validates :name_column, presence: true, if: -> { not headers_format? }
  validates :email_column, presence: true, if: -> { not headers_format? }
  validates :birthday_column, presence: true, if: -> { not headers_format? }
  validates :phone_column, presence: true, if: -> { not headers_format? }
  validates :address_column, presence: true, if: -> { not headers_format? }
  validates :credit_card_number_column,  presence: true, if: -> { not headers_format? }


  before_validation :set_initial_status

  def to_s
    status_tag = " (#{ translated_status })" if status.present?
    "#{ self.singularize } #{ id }#{ status_tag }"
  end

  def parse_contacts
    case status
    when 'waiting'
      self.status = :processing
      self.save
      self.parse_contacts
    when 'processing'
      status = parse_csv_file ? :done : :fail # parse_csv_file returns true if all contacts parsed were valid
      self.update_attribute(:status, status) # avoid validations for contacts
    when 'fail'
      if self.valid?
        self.status = :done
        self.save
      end
    when 'done'
      unless self.valid?
        self.status = :fail
        self.save
      end
    end
  end

  private
  protected
  def set_initial_status
    if new_record? and file.present?
      self.status = :waiting
    elsif file.attached? and file.attachment.id.nil?
      byebug
      self.status = :waiting
    end
  end

  def get_headers_names
    headers_names = Hash.new
    if headers? and headers_format?
      headers_names[:name] = :nombre
      headers_names[:birthday] = :fecha_de_nacimiento
      headers_names[:phone] = :telefono
      headers_names[:address] = :direccion
      headers_names[:credit_card_number] = :tarjeta_de_credito
      headers_names[:email] = :email
    else
      headers_names[:name] = name_column - 1
      headers_names[:birthday] = birthday_column - 1
      headers_names[:phone] = phone_column - 1
      headers_names[:address] = address_column - 1
      headers_names[:credit_card_number] = credit_card_number_column - 1
      headers_names[:email] = email_column - 1
    end

    headers_names
  end

  def parse_csv_file
    headers_names = get_headers_names # Hash with headers
    all_contacts_valid = true

    CSV.parse(file.download, headers: headers, header_converters: :symbol) do |row|
      contact = self.contacts.build(
        name: row[headers_names[:name]],
        birthday: row[headers_names[:birthday]],
        phone: row[headers_names[:phone]],
        address: row[headers_names[:address]],
        credit_card_number: row[headers_names[:credit_card_number]],
        email: row[headers_names[:email]]
      )
      contact.parsing_from_csv = true

      if contact.valid?
        contact.active = true
        contact.skip_validations = true
        contact.save
      else
        contact.active = false
        contact.skip_validations = true
        contact.save
        all_contacts_valid = false
      end
    end

    all_contacts_valid
  end
end

# == Schema Information
# Schema version: 20210309095626
#
# Table name: csv_files
#
#  id                        :integer          not null, primary key
#  address_column            :integer
#  birthday_column           :integer
#  credit_card_number_column :integer
#  email_column              :integer
#  headers                   :boolean          default(FALSE)
#  headers_format            :boolean          default(FALSE)
#  name_column               :integer
#  phone_column              :integer
#  status                    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
