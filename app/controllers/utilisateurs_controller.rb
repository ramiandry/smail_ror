class UtilisateursController < ApplicationController
  layout "layout", only: [ :profile ] # Spécifie que ce layout s'applique uniquement à la méthode :profile
  before_action :authentifier_utilisateur!, only: [ :profile ] # Applique le before_action uniquement à la méthode :profile

  # Affiche tous les utilisateurs
  def index
    @utilisateurs = Utilisateur.all
  end

  # Affiche un utilisateur spécifique
  def show
    @utilisateur = Utilisateur.find(params[:id])
  end

  def profile
    @utilisateur = Utilisateur.find(session[:utilisateur_id])
  end

  # Affiche le formulaire pour créer un nouvel utilisateur
  def new
    @utilisateur = Utilisateur.new
  end

  # Crée un nouvel utilisateur
  def create
    @utilisateur = Utilisateur.new(utilisateur_params)
    if @utilisateur.save
      redirect_to login_path, notice: "Utilisateur créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Affiche le formulaire pour éditer un utilisateur existant
  def edit
    @utilisateur = Utilisateur.find(params[:id])
  end

  # Met à jour un utilisateur existant
  def update
    print utilisateur_params
    @utilisateur = Utilisateur.find(session[:utilisateur_id])
    if @utilisateur.update(utilisateur_params)
      redirect_to @utilisateur, notice: "Utilisateur mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Supprime un utilisateur
  def destroy
    @utilisateur = Utilisateur.find(params[:id])
    @utilisateur.destroy
    redirect_to utilisateurs_path, notice: "Utilisateur supprimé avec succès."
  end

  private

  # Strong Parameters pour sécuriser les paramètres
  def utilisateur_params
    params.require(:utilisateur).permit(:nom, :prenom, :email, :avatar, :sexe, :adresse, :tel, :date_naissance, :password, :password_confirmation)
  end

  private
  # Méthode pour vérifier si un utilisateur est connecté
  def authentifier_utilisateur!
    unless utilisateur_connecte?
      redirect_to login_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end
end
