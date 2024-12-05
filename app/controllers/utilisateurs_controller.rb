class UtilisateursController < ApplicationController
  layout "layout", only: [ :profile, :show, :settings ] # Spécifie que ce layout s'applique uniquement à la méthode :profile
  before_action :authentifier_utilisateur!, only: [ :profile, :show, :settings ] # Applique le before_action uniquement à la méthode :profile
  require "device_detector"
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

  def settings
    @utilisateur = Utilisateur.find(session[:utilisateur_id])
    @utilisateurs = Utilisateur.all
    @utilisateurs_non_bloques = Utilisateur.where.not(id: @utilisateur.bloques.pluck(:id))
    @utilisateurs_bloques = @utilisateur.bloques
    @device_info = @utilisateur.devices.order(created_at: :desc)
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

  def blocage
    @users_block=params[:user_ids]
    @utilisateur = Utilisateur.find(session[:utilisateur_id])
    @users_block.each do |user|
      user_to_block=Utilisateur.find(user)
      @utilisateur.bloqueurs.create(bloquer: user_to_block)
    end
    redirect_to settings_path
  end

  def debloquer
    @utilisateur = Utilisateur.find(session[:utilisateur_id])  # Utilisateur actuel
    @utilisateur_bloque = Utilisateur.find(params[:id])  # Utilisateur à débloquer

    # Supprimer l'association de blocage
    bloqueur = @utilisateur.bloqueurs.find_by(bloquer: @utilisateur_bloque)
    bloqueur.destroy if bloqueur

    redirect_to settings_path, notice: "L'utilisateur a été débloqué avec succès."
  end

  def editPass
      @utilisateur = Utilisateur.find(session[:utilisateur_id])
      @utilisateur.update(password_params)
      redirect_to settings_path
  end

  # Met à jour un utilisateur existant
  def update
    print utilisateur_params
    @utilisateur = Utilisateur.find(session[:utilisateur_id])
    if @utilisateur.update(utilisateur_params)
    redirect_to root_path, notice: "Utilisateur mis à jour avec succès."
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

  private
  # Autoriser uniquement les champs de mot de passe
  def password_params
    params.require(:utilisateur).permit(:password, :password_confirmation)
  end
end
