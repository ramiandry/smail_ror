require "sidekiq-cron"

schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) && Sidekiq.server?
  begin
    schedule = YAML.load_file(schedule_file)
    Sidekiq::Cron::Job.load_from_hash(schedule || {})
  rescue StandardError => e
    Rails.logger.error "Erreur lors du chargement des tâches cron : #{e.message}"
  end
end
