class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_utilisateur, :utilisateur_connecte?
  before_action :set_layout_data

  private

  def current_utilisateur
    @current_utilisateur ||= Utilisateur.find(session[:utilisateur_id]) if session[:utilisateur_id]
  end

  def utilisateur_connecte?
    current_utilisateur.present?
  end

  def set_layout_data
    @user=Utilisateur.find(session[:utilisateur_id])
    @app_name = "Smail"  # Donnée accessible dans le layout
    @utilisateur_connecte = utilisateur_connecte?  # L'état de la connexion de l'utilisateur
  end
end
