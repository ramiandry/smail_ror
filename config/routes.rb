Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  patch "receptions/supprimer", to: "receptions#supprimer"
  post "receptions/transfert", to: "receptions#transfert", as: :transfert
  patch "emails/supprimer", to: "emails#supprimer"
  get "emails/new", to: "emails#new", as: :newemails
  get "emails/envoyer", to: "emails#envoyer", as: :envoyer
  get "emails/spam", to: "emails#showSpam", as: :spam
  get "emails/archive", to: "emails#showArchive", as: :archive
  get "emails/favoris", to: "emails#showFavoris", as: :favoris
  get "emails/corbeille", to: "emails#corbeille", as: :corbeille
  post "emails/create", to: "emails#create", as: :emails
  post "emails/destroy/:id", to: "emails#destroy"
  patch "emails/restaurer/:id", to: "emails#restaurer"
  patch "receptions/restaurer/:id", to: "receptions#restaurer"
  post "receptions/destroy/:id", to: "receptions#destroy"
  post "emails/archiver/:id", to: "emails#archiver"
  post "emails/spam/:id", to: "emails#spam"
  get "emails/search", to: "emails#search", as: :search
  get "emails/favoris/:id", to: "emails#favoris"
  get "emails/non_lu/:id", to: "emails#non_lu"
  get "signin", to: "utilisateurs#index", as: :login
  get "utilisateurs/profile", to: "utilisateurs#profile", as: :profile
  get "utilisateurs/show/:id", to: "utilisateurs#show", as: :profile_show
  post "utilisateurs/create", to: "utilisateurs#create", as: :utilisateurs
  get "register", to: "utilisateurs#new"
  patch "utilisateurs/update", to: "utilisateurs#update", as: :edit_profile
  post "login", to: "sessions#create", as: :session
  delete "logout", to: "sessions#destroy"
  get "emails/:etat/:id", to: "emails#show"
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
