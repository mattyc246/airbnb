class Listing < ApplicationRecord

  belongs_to :user

	def self.for_select
		{
               'Apartment' => ['Apartment','Condominium','Casa Particular','Loft','Serviced Apartment'],
               'House' => ['House','Bungalow','Cabin','Casa Particular','Chalet','Cottage','Cycladic House','Dammuso','Dome House','Earth House','Farm Stay','Houseboat','Hut','Light House','Pension','Shepherds Hut','Tiny House','Townhouse','Trullo','Villa'],
               'Secondary Unit' => ['Guest House','Guest Suite','Farm Stay'],
               'Unique Space' => ['Barn','Boat','Bus','Camper/RV','Campsite','Castle','Cove','Dome House','Earth House','Farmstay','Houseboat','Hut','Igloo','Island','Lighthouse','Pension','Plane','Shepherds Hut','Tent','Tiny House','Tipi','Train','Treehouse','Windmill','Yurt'],
               'Bed & Breakfast' => ['Bed & Breakfast','Casa Particular','Farmstay','Minsu','Nature Lodge','Ryokan'],
               'Boutique Hotel' => ['Boutique Hotel','Aparthotel','Heritage Hotel','Hostel','Hotel','Nature Lodge','Resort','Serviced Apartment']
          }
	end

     def country_name
       full_country = ISO3166::Country[country]
       full_country.translations[I18n.locale.to_s] || full_country.name
     end

end