# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class AddCsvFileIdAndActiveToContacts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contacts, :csv_file, foreign_key: true, index: true
    add_column :contacts, :active, :boolean
  end
end
