class Planet < ApplicationRecord
    self.table_name = "exploration_planet"

    has_many :locations

    validates :name, presence: true
    validates :image_url, presence: true
end
