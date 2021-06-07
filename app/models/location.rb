class Location < ApplicationRecord
  self.table_name = "exploration_planet_location"
  belongs_to :planet
end
