class User < ApplicationRecord
  include Clearance::User

   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :date_of_birth, presence: true
   validates :email, presence: true
   validates :password, presence: true, on: :create
   validates :contact_number, presence: true

   has_many :authentications, dependent: :destroy
   has_many :listings, dependent: :destroy
   has_many :bookings, dependent: :destroy
   mount_uploader :avatar, AvatarUploader

 def self.create_with_auth_and_hash(authentication, auth_hash)
  
   user = self.create!(
     first_name: auth_hash["info"]["first_name"],
     last_name: auth_hash["info"]["last_name"],
     email: auth_hash["info"]["email"],
     contact_number: auth_hash["info"]["phone"],
     date_of_birth: auth_hash["info"]["birthdate"]
     password: SecureRandom.hex(10)
   )
   user.authentications << authentication
   return user
 end

   # grab google to access google for user data
   def google_token
     x = self.authentications.find_by(provider: 'google_oauth2')
     return x.token unless x.nil?
   end
 end
