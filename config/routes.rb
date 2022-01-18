Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    get '/points_balance', to: 'points#index', as: 'points_balance'
    patch '/spend_points', to: 'points#edit', as: 'spend_points'
  end
end
