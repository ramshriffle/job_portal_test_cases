Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  resources :users
  post 'user/login', to: 'users#login'
  resource :user_profiles
  resources :jobs
  resources :users_application
    
  resources :job_recruiters do
    member do
      get 'view_list_of_job_application'
      put 'accept_or_reject_job_application'
      get 'view_accepted_job_application'
      get 'view_rejected_job_application'
    end
  end
  post 'password/forgot', to: 'passwords#forgot_password'
  post 'password/reset', to: 'passwords#reset_password'
end
