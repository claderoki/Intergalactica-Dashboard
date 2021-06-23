class Scenario < ApplicationRecord
  self.table_name = "exploration_action_scenario"

  belongs_to :action
  belongs_to :scenario_winnings
end
