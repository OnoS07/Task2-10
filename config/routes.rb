Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#home"
  get "/" => "users#home"
  get "/home/about" => "users#about"

resources :users, only:[:show, :edit, :update, :index]

resources :books do
	resources :book_comments, only:[:create, :destroy]
	resource :favorites, only:[:create, :destroy]
end

end
