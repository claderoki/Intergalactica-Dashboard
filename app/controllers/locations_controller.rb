class LocationsController < ApplicationController
    def save_locations
        @planet = Planet.find(params[:id])

        locations_to_remove = []
        new_locations = []

        for location in @planet.locations do
            locations_to_remove.push(location)
        end

        params[:locations].each do |key, location|
            if key == '{{index}}'
                next
            end

            @new = location[:id] == ""
            @found = false
            @changed = false
            if ! @new
                for storedLocation in @planet.locations do
                    if storedLocation.id == Integer(location[:id])
                        locations_to_remove.delete(storedLocation)
                        @found = true
                        if storedLocation.name != location[:name]
                            @changed = true
                        end
                    end
                end
            end

            if @new
                @location = @planet.locations.create(name: location[:name])
                new_locations.push(@location)
            else
                @location = Location.find(location[:id])
                if @changed
                    @location.update(name: location[:name])
                    @location.name = location[:name]
                end
                new_locations.push(@location)
            end
        end

        locations_to_remove.each do location
            location.destroy()
        end

        render json: { html: render_to_string(partial: 'shared/table', locals: {template: false, items: new_locations, namespace: 'locations', columns: ['name']}) }
    end

end
