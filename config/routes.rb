Rails.application.routes.draw do
  resources :process_instances do
    collection do
      get :search
    end
    member do
      resources :process_variables, only: [:update, :update_binary, :data, :delete], param: :name do
        member do
          get :data
          put :update_binary
          delete :delete
        end
      end
      get :diagram
      get :diagram_box
    end
  end

  namespace :history do
    resources :process_instances do
      collection do
        get :search
      end
      member do
        resources :process_variables, only: [:data], param: :name do
          member do
            get :data
          end
        end
      end
    end
  end

  resources :process_jobs, only: [:index, :update, :destroy] do
    member do
      get :stacktrace
      get :stacktrace_box
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  get '/signin'   => 'sessions#new'
  get '/signout'  => 'sessions#destroy', via: 'delete'

  root 'process_instances#index'
end
