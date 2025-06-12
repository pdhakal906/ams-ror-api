class User < ApplicationRecord
  has_secure_password
  enum :gender, { m: "m", f: "f", o: "o" }
  enum :role, { super_admin: "super_admin", artist_manager: "artist_manager", artist: "artist" }

  validates :first_name, :last_name, :dob, :address, presence: true
  validates :phone, length: { maximum: 20 }, allow_blank: true
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, on: :create
  validates :role, presence: true, on: :create
end
