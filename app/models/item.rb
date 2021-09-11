class Item < ApplicationRecord
  self.table_name = "item"

  belongs_to :category

  validates :name, presence: true
end
