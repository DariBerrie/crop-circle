class Farm < ApplicationRecord
  belongs_to :user
  geocoded by :address
  after_validation :geocode
end
