Rails.application.routes.draw do
  resources :users
  post 'asset/add'

  put 'asset/update_price'

  get 'asset/list'

  get 'asset/get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
