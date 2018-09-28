# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = {}
user['password'] = '1234'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['contact_number'] = Faker::PhoneNumber.phone_number
    user['date_of_birth'] = Faker::Date.between(50.years.ago, Date.today)
    user['auth_level'] = ['basic','host'].sample

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.where(auth_level: "host").each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['name'] = Faker::App.name
    listing['place_type'] = ["Apartment","House","Secondary Unit","Unique Space","Bed & Breakfast","Boutique Hotel"].sample
    
    	if listing['place_type'] == "Apartment"
    		listing['property_type'] = ['Apartment','Condominium','Casa Particular','Loft','Serviced Apartment'].sample
    	elsif listing['place_type'] == "House"
    		listing['property_type'] = ['House','Bungalow','Cabin','Casa Particular','Chalet','Cottage','Cycladic House','Dammuso','Dome House','Earth House','Farm Stay','Houseboat','Hut','Light House','Pension','Shepherds Hut','Tiny House','Townhouse','Trullo','Villa'].sample
    	elsif listing['place_type'] == "Secondary Unit"
    		listing['property_type'] = ['Guest House','Guest Suite','Farm Stay'].sample
    	elsif listing['place_type'] == "Unique Space"
    		listing['property_type'] = ['Barn','Boat','Bus','Camper/RV','Campsite','Castle','Cove','Dome House','Earth House','Farmstay','Houseboat','Hut','Igloo','Island','Lighthouse','Pension','Plane','Shepherds Hut','Tent','Tiny House','Tipi','Train','Treehouse','Windmill','Yurt'].sample
    	elsif listing['place_type'] == "Bed & Breakfast"
    		listing['property_type'] = ['Bed & Breakfast','Casa Particular','Farmstay','Minsu','Nature Lodge','Ryokan'].sample
    	elsif listing['place_type'] == "Boutique Hotel"
    		listing['property_type'] = ['Boutique Hotel','Aparthotel','Heritage Hotel','Hostel','Hotel','Nature Lodge','Resort','Serviced Apartment'].sample
    	end

    listing['room_number'] = rand(0..5)
    listing['bed_number'] = rand(1..6)
    listing['guest_number'] = rand(1..30)

    listing['country'] = Faker::Address.country
    listing['state'] = Faker::Address.state
    listing['city'] = Faker::Address.city
    listing['zipcode'] = Faker::Address.zip_code
    listing['address'] = Faker::Address.street_address

    listing['price'] = rand(10..250)
    listing['description'] = Faker::Hipster.sentence
    listing['verified'] = [false, true].sample

    
    listing['user_id'] = uids.sample

    listing['avatars'] = [Rails.root.join("app/assets/images/stock/#{rand(1..20)}.jpeg").open, 
                            Rails.root.join("app/assets/images/stock/#{rand(1..20)}.jpeg").open, 
                            Rails.root.join("app/assets/images/stock/#{rand(1..20)}.jpeg").open]

    Listing.create(listing)
  end
end