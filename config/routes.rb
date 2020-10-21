Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :merchants, except: [:new, :edit]
      # namespace :merchants do
      #   get '/:id/items', to: 'items#index'
      # end
      #
      # resources :items, except: [:new, :edit]
      # namespace :items do
      #   get '/:id/merchants', to: 'merchants#index'
      # end

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        resources :items, only: [:index], module: :merchants
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], module: :items
      end
    end
  end
end
