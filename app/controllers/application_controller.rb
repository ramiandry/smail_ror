class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_utilisateur, :utilisateur_connecte?

  private

  def current_utilisateur
    @current_utilisateur ||= Utilisateur.find(session[:utilisateur_id]) if session[:utilisateur_id]
  end

  def utilisateur_connecte?
    current_utilisateur.present?
  end
end
