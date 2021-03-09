class CreateCsvFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :csv_files do |t|
      t.integer :status
      t.boolean :headers, default: false
      t.boolean :headers_format, default: false
      t.integer :name_column
      t.integer :birthday_column
      t.integer :phone_column
      t.integer :address_column
      t.integer :credit_card_number_column
      t.integer :email_column

      t.timestamps
    end
  end
end
