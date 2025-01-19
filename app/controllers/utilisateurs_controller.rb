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
        @email = Email.new(
          objet: "Bienvenue sur Smail",
          corps: '
          <div style="font-family: Arial, sans-serif; font-size: 16px; line-height: 1.6; color: #333;  padding: 20px;">
          <div style="max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <div style="background-color: #4e73df; color: white; text-align: center; padding: 20px;">
              <h1 style="margin: 0; font-size: 24px;">Welcome to Smail!</h1>
            </div>
            <div style="padding: 20px;">
              <p>We are thrilled to welcome you to our platform. Smail is your ultimate messaging management solution, designed to make your communication seamless and efficient.</p>
              <p>If you have any questions or need assistance, feel free to reach out to our support team anytime.</p>
              <br>
              <p style="color: #555; text-align: center;">
                Best regards,<br>
                <strong>The Smail Team</strong>
              </p>
            </div>
            <div style="background-color: #4e73df; color: white; text-align: center; padding: 10px;">
              <p style="margin: 0; font-size: 12px;">&copy; 2025 Smail. All rights reserved.</p>
            </div>
          </div>
        </div>

          ',
          expediteur: Utilisateur.last, # Associe l'utilisateur comme expéditeur
        )
        @email.save
        reception = Reception.new(utilisateur_id: @utilisateur.id, email_id: @email.id)
        if reception.save
          flash[:notice] = "Utilisateur créé avec succès. Votre email : #{@utilisateur.email}"
        redirect_to login_path
        end
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
