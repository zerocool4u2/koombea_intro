# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'ffaker'

Contact = Struct.new(:name, :birthday, :phone, :address, :credit_card_number, :email)

def generate_contacts(filename: 'spec/fixtures/files/contacts.csv', iterations: 1, delimiter: ',')
  file =  File.open filename, 'w+'

  iterations.times do
    contact = Contact.new(FFaker::Name.name.gsub(?', ''), FFaker::Time.between(Time.now - 100.years, Time.now).to_date.iso8601, '(+57) 320-432-05-09', FFaker::Address.street_address, '371449635398431', FFaker::Internet.email)

    file.puts [contact.name, contact.birthday, contact.phone, contact.address, contact.credit_card_number, contact.email].join(delimiter)
  end

  file.close
end
