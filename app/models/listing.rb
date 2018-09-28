class Listing < ApplicationRecord

  include PgSearch
  belongs_to :user
  has_many :bookings, dependent: :destroy
  paginates_per 10
  mount_uploaders :avatars, AvatarUploader
  pg_search_scope :search_by_city,
                  :against => :city,
                  :using => {:tsearch => {:prefix => true}}
  validates :name, presence: true
  validates :place_type, presence: true
  validates :property_type, presence: true
  validates :room_number, presence: true
  validates :bed_number, presence: true
  validates :guest_number, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :description, presence: true


  def self.for_update
    
    {
      'Name' => 'listing[name]',
      'Place Type' => 'listing[place_type]',
      'Property Type' => 'listing[property_type]',
      'Number Of Rooms' => 'listing[room_number]',
      'Number Of Beds' => 'listing[bed_number]',
      'Number Of Guests' => 'listing[guest_number]',
      'Country' => 'listing[country]',
      'State' => 'listing[state]',
      'City' => 'listing[city]',
      'Zipcode' => 'listing[zipcode]',
      'Address' => 'listing[address]',
      'Price' => 'listing[price]',
      'Description' => 'listing[description]',
      'Add Photos To Listing' => 'listing[avatar]'

    }

  end 

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