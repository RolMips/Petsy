class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :firstname
      t.string :lastname
      t.string :email
      t.boolean :confirmed, default: false
      t.string :confirmation_token
      t.string :password_digest
      t.boolean :avatar, default: false
      t.timestamps
    end
  end
end