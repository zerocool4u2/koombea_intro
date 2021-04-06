# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class Contact < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  attribute :skip_validations, :boolean
  attribute :parsing_from_csv, :boolean

  belongs_to :csv_file, optional: true # Not every contact would come from a csv file

  before_validation :set_franchise

  # Alternative /\A[ \-a-zA-Z]+\z/
  # http://www.micropress-inc.com/fonts/encoding/t1.htm
  # Support for letters, accents and minus symbol (-)
  validates :name, presence: true,
    format: /\A[ \-a-zA-Z\u0080-\u009B\u00A0-\u00BB\u00C0-\u00DD\u00E0-\u00FD]+\z/,
    unless: -> { skip_validations? }

  validates :birthday, presence: true,
    iso_date_format: true,
    unless: -> { skip_validations? }

  validates :phone, presence: true,
    format: /\A\(\+\d{2}\) (\d{3}[ |-]){2}\d{2}[ |-]\d{2}\z/,
    unless: -> { skip_validations? }

  validates :address, presence: true,
    unless: -> { skip_validations? }

  validates :credit_card_number, presence: true,
    credit_card_format: true,
    unless: -> { skip_validations? }

  validates :franchise, presence: true,
    if: -> { credit_card_number.present? },
    unless: -> { skip_validations? }

  validates :email, presence: true,
    uniqueness: true,
    format: /\A[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/,
    unless: -> { skip_validations? }

  before_save :check_active, unless: -> { parsing_from_csv? }

  def to_s
    name.present? ? name : name_was
  end

  private
  protected
  def set_franchise
    self.franchise = credit_card_number.present? ? CreditCardValidator::Validator.card_type(credit_card_number) : nil
  end

  def check_active
    self.active = valid?
  end
end

# == Schema Information
# Schema version: 20210307100046
#
# Table name: contacts
#
#  id                 :integer          not null, primary key
#  active             :boolean
#  address            :string
#  birthday           :string
#  credit_card_number :string
#  email              :string
#  franchise          :string
#  name               :string
#  phone              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  csv_file_id        :integer          indexed
#
# Indexes
#
#  index_contacts_on_csv_file_id  (csv_file_id)
#
# Foreign Keys
#
#  csv_file_id  (csv_file_id => csv_files.id)
#
