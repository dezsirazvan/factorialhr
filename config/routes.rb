Rails.application.routes.draw do
  apipie
  namespace :api do 
    namespace :v1 do 
      resources :contacts do
        get :versions, on: :member
      end

      resources :metrics do
        get :timeline, on: :collection
      end
    end
  end

  get 'welcome/index'
  root to: 'welcome#index'
end
