Rails.application.routes.draw do
  resources :contacts do
    get :versions, on: :member
  end

  resources :metrics do
  end

  get 'welcome/index'
  root to: 'welcome#index'
end
