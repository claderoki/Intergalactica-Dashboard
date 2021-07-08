class ScenariosController < ApplicationController

    private def save_winnings(value)
        new = value[:id] == ""

        if new
            winnings = ScenarioWinnings.create(
                gold:        Integer(value[:gold]),
                experience:  Integer(value[:experience]),
                health:      Integer(value[:health]),
                food:        Integer(value[:food]),
                happiness:   Integer(value[:happiness]),
                cleanliness: Integer(value[:cleanliness]),
            )
            @references[value[:reference]] = winnings.id
        else
            winnings = ScenarioWinnings.find(value[:id])
            winnings.update(
                gold:        Integer(value[:gold]),
                experience:  Integer(value[:experience]),
                health:      Integer(value[:health]),
                food:        Integer(value[:food]),
                happiness:   Integer(value[:happiness]),
                cleanliness: Integer(value[:cleanliness]),
            )
        end

        @processed_winnings.push(winnings.id)
        return winnings
    end

    private def save_scenario(value)
        new = value[:id] == ""
        winnings = save_winnings(value[:winnings])

        if new
            scenario = @action.scenarios.create(
                text: value[:text],
                scenario_winnings: winnings
            )
            @references[value[:reference]] = scenario.id
        else
            scenario = Scenario.find(value[:id])
            scenario.update(text: value[:text])
        end
        return scenario
    end

    private def clean_removed()
        if @processed_winnings.count() > 0
            winnings_to_remove = ScenarioWinnings.select('id').where('(id NOT IN (?) AND id IN (SELECT scenario_winnings_id FROM exploration_action_scenario WHERE action_id = ?) )', @processed_winnings, @action.id)
            for winnings in winnings_to_remove do
                winnings.destroy()
            end
        end
    end

    def save_scenarios
        @action = Action.find(params[:action_id])
        @references = Hash.new
        @processed_winnings = []

        params[:scenarios].each do |key, value|
            if key != '{{index}}'
                save_scenario(value)
            end
        end

        clean_removed()

        render json: { references: @references}
    end

end
