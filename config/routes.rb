Rails.application.routes.draw do
  get "receptions/index"
  get "receptions/show"
  get "receptions/create"
  get "emails", to: "emails#index"
  get "emails/show"
  get "emails/new", to: "emails#new"
  get "emails/edit"
  get "login", to: "utilisateurs#index", as: :login
  get "utilisateurs/show"
  post "utilisateurs/create", to: "utilisateurs#create", as: :utilisateurs
  get "register", to: "utilisateurs#new"
  get "utilisateurs/edit"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
