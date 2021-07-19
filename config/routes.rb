Rails.application.routes.draw do
  resources :contacts

  get 'welcome/index'
  root to: 'welcome#index'
end
