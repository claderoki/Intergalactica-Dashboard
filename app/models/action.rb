class Action < ApplicationRecord
  self.table_name = "exploration_action"

  has_many :scenarios

  belongs_to :location
  belongs_to :planet
end
