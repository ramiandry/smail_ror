class DailyReportJob < ApplicationJob
  queue_as :default

  def perform
    # Logique de la tâche
    puts "Envoi du rapport quotidien"
    # Exemple : UserMailer.daily_report.deliver_now
  end
end
