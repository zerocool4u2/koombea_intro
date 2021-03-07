class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :birthday
      t.string :phone
      t.string :address
      t.string :credit_card_number
      t.string :franchise

      t.timestamps
    end
  end
end
