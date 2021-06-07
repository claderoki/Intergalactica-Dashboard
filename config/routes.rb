Rails.application.routes.draw do

  resources :planets

  post "/save_all", to: "locations#save_all"
  get "/render_all", to: "locations#render_all"
end
