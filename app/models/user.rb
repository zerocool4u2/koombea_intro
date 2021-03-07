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
