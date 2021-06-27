class ActionsController < ApplicationController
    def index
        @actions = Action.all
    end

    def show
        @action = Action.find(params[:id])
    end

    def new
        @action = Action.new
        @planets = Planet.find_by_sql("SELECT id, name FROM exploration_planet")
        @locations = Location.find_by_sql("
            SELECT
            `exploration_planet_location`.`id`,
            CONCAT(`exploration_planet_location`.`name`, ' (',`exploration_planet`.`name` ,')') as name
            FROM exploration_planet_location
            INNER JOIN exploration_planet ON exploration_planet_location.planet_id = exploration_planet.id"
        )
    end

    def save_action
        if params[:id] == "" || params[:id] == 0
            location = Location.find(params[:location_id])
            planet   = Planet.find(params[:planet_id])
            @action = Action.new(
                :name     => params[:name],
                :location => location,
                :planet   => planet,
                :code     => '',
                :symbol   => params[:symbol]
            )
            if @action.save
                redirect_to '/actions/'+String(@action.id)+'/edit'
            else
                render :new
            end
        else
            @action = Action.find(params[:id])
            if @action.update(:name => params[:name], :symbol => params[:symbol])
                render :edit
            else
                render :edit
            end

        end
    end

    def create
        render :new
    end

    def edit
        @action = Action.find(params[:id])
        if @action.location != nil
            @abc = Location.find_by_sql(["
                SELECT
                CONCAT(`exploration_planet_location`.`name`, ' (',`exploration_planet`.`name` ,')') as name
                FROM exploration_planet_location
                INNER JOIN exploration_planet ON exploration_planet_location.planet_id = exploration_planet.id
                WHERE exploration_planet_location.id = ?
                ", @action.location.id]
            )
            @contextualLocation = @abc[0].name
        else
            @contextualLocation = @action.planet.name
        end
    end

    def update
        @action = Action.find(params[:id])

        if @action.update(action_params)
            render :edit
        else
            render :edit
        end
    end

    def destroy
        @action = Action.find(params[:id])
        @action.destroy
        redirect_to '/actions'
    end

    private
    def action_params
        params.require(:action).permit(:name)
    end
end
