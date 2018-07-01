Rails.application.routes.draw do
  resources :users
  get 'asset/add'

  get 'asset/update_price'

  get 'asset/list'

  get 'asset/get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
