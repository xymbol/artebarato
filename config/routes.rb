Rails.application.routes.draw do
  resources :categories, path: "categorias", only: [] do
    resources :events, path: "eventos", only: :index
  end

  root to: 'events#index'
end
