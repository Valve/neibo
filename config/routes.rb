Neibo::Application.routes.draw do
  root to: 'people#index'
  resources :people
end
