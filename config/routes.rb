Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "receptions/index"
  get "receptions/show"
  get "receptions/create"
  get "emails/show"
  get "emails/new", to: "emails#new", as: :newemails
  post "emails/create", to: "emails#create", as: :emails
  get "emails/edit"
  get "signin", to: "utilisateurs#index", as: :login
  get "utilisateurs/show"
  post "utilisateurs/create", to: "utilisateurs#create", as: :utilisateurs
  get "register", to: "utilisateurs#new"
  get "utilisateurs/edit"
  post "login", to: "sessions#create", as: :session
  delete "logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "emails#index"
end
