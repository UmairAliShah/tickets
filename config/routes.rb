Rails.application.routes.draw do


  resources :products do
    member do
      get :approve_product
    end
  end

  namespace :user do
    resources :profiles
    resources :dashboard
  end

  namespace :admin do
    resources :homes do
      collection do
        get :approved_products
        get :unapproved_products
      end
    end
  end

  devise_for :users, path: 'users', controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_for :admins, path: 'new-app-auth-admins'

  resources :homes do
    collection do
      post :search
      get :products
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
