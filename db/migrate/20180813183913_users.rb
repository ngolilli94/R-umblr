class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :username
      t.string :password
      t.string :email
      t.string :first_name
      t.string :last_name
      t.date :birthday
    end
  end
end
