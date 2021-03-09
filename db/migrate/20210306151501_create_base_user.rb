class CreateBaseUser < ActiveRecord::Migration[6.1]
  def up
    User.create(
      email: 'test@example.com',
      password: 'password'
    )
  end
end
