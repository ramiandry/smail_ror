class SessionsController < ApplicationController
  def new
  end

  def create
    utilisateur = Utilisateur.find_by(email: params[:email])
    if utilisateur&.authenticate(params[:password_digest])
      session[:utilisateur_id] = utilisateur.id  # Créer la session pour l'utilisateur
      session[:utilisateur_nom] = utilisateur.nom  # Créer la session pour l'utilisateur
      session[:utilisateur_prenom] = utilisateur.prenom  # Créer la session pour l'utilisateur
      redirect_to root_path, notice: "Bienvenue, #{utilisateur.nom}!"
    else
      flash.now[:alert] = "Email ou mot de passe incorrect"
      render :new
    end
  end

  def destroy
    session[:utilisateur_id] = nil  # Supprimer la session pour déconnecter l'utilisateur
    redirect_to login_path, notice: "Vous êtes déconnecté."
  end
end
