Rails.application.routes.draw do
  root "home#index"

  constraints(AdminConstraint.new) do
    resources :actions
    resources :planets
    resources :items

    post "/save_action", to: "actions#save_action"
    get "/render_all", to: "locations#render_all"
    post "/save_locations", to: "locations#save_locations"
    post "/save_scenarios", to: "scenarios#save_scenarios"

  end

  get "/authenticate", to: "oauth#authenticate"
  get "/authenticated", to: "oauth#authenticated"

end
