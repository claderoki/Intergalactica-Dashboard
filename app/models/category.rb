class Category < ApplicationRecord
  self.table_name = "item_category"

  has_many :items
end
