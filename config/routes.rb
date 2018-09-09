Rails.application.routes.draw do
  resources :categories, path: "", only: [] do
    resources :events, path: "", only: :index
  end

  root to: 'events#index'
end
