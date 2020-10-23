Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:merchant_id/items', to: 'items#index'
        get '/:merchant_id/revenue', to: 'revenue#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'business#most_revenue_index'
        get '/most_items', to: 'business#most_items_index'
      end
      namespace :items do
        get '/:item_id/merchant', to: 'merchant#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
    end
  end
end
