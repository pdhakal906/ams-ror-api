class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 255
      t.string :last_name, null: false, limit: 255
      t.string :email, null: false, limit: 255, index: { unique: true }
      t.string :password_digest, null: false, limit: 255
      t.string :phone, limit: 20
      t.datetime :dob, null: false
      t.string :gender, limit: 1
      t.string :address, null: false, limit: 255
      t.string :role, null: false
      t.timestamps
    end
  end
end
