# lib/tasks/import.rake
namespace :import do
  desc "Import card sets from the Pokemon TCG API"
  task sets: :environment do
    puts "Starting import task"
    ImportService.new.import_sets
    puts "Finished import task"
  end
end
