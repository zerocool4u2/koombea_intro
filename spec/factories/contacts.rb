# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

FactoryBot.define do
  factory :contact do
    name { FFaker::Name.name.gsub(?', '') }
    birthday { FFaker::Time.between(Time.now - 100.years, Time.now).to_date.iso8601 }
    phone { '(+57) 320-432-05-09' }
    address { FFaker::Address.street_address }
    credit_card_number { '371449635398431' }
    email { FFaker::Internet.email }
  end
end
