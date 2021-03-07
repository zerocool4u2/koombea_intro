# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class Contact < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }

  belongs_to :csv_file, optional: true # Not every contact would come from a csv file

  before_validation :set_franchise

  # Alternative /\A[\-a-zA-Z]+\z/
  # http://www.micropress-inc.com/fonts/encoding/t1.htm
  # Support for letters, accents and minus symbol (-)
  validates :name, presence: true, format: /\A[\-a-zA-Z\u0080-\u009B\u00A0-\u00BB\u00C0-\u00DD\u00E0-\u00FD]+\z/

  validates :email, presence: true, uniqueness: true, format: /[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/

  validates :birthday, presence: true, iso_date_format: true

  validates :phone, presence: true

  validates :address, presence: true

  validates :credit_card_number, presence: true, credit_card_format: true

  validates :franchise, presence: true, if: -> { credit_card_number.present? }

  def to_s
    name.present? ? name : name_was
  end

  private
  protected
  def set_franchise
    self.franchise = credit_card_number.present? ? CreditCardValidator::Validator.card_type(credit_card_number) : nil
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
