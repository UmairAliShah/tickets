Rails.application.routes.draw do

  namespace :admin do
    resources :homes
  end

  devise_for :users, path: 'users'
  devise_for :admins, path: 'new-app-auth-admins'

  resources :homes do
    collection do
      post :search
    end
  end


  namespace :api, defaults: {format: :json} do
     namespace :v1 do
       resources :registrations, :only => [:create]
       resources :sessions, :only => [:create, :destroy]
     end
  end

 authenticated :user do
   root :to => 'homes#index'
 end
 authenticated :admin do
   #root :to => 'admin/stocks#index'
   root :to => 'admin/homes#index'
 end

  root to: 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
