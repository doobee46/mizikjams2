require 'spinner.rb'
namespace :site do
  desc "Syncing JWplatform data(cdn) with app"
  task :sync do |t, args|
      spinner = Spinner.new
    spinner.task("Cleanning Database", 'db:all')
    spinner.task("Creating Catgeory", 'category:create')
    spinner.task("Syncing video with app", 'site:publish')
    spinner.spin!
  end
end