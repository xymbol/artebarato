namespace :events do
  desc "Update events from timeline"
  task update: :environment do
    EventsUpdater.update
  end
end
