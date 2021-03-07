# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  def to_s
    email.blank? ? email_was : email
  end
end

# == Schema Information
# Schema version: 20210307100046
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null, indexed
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
