begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new

namespace :fraternity do
  task :install do
    # read the migration
    base_file_name = "create_pledges.rb"
    template = File.join File.dirname(__FILE__), "lib/generators/fraternity/templates/migration", base_file_name
    contents = File.open(template) { |f| f.read }

    # create the migration
    destination = ENV["DESTINATION"] || "."
    unless File.directory?(destination)
      FileUtils.mkdir_p destination
    end
    timestamp = Time.now.to_i
    destination_file = File.join destination, "#{timestamp}_#{base_file_name}"
    File.open(destination_file, 'w') { |f| f.write(contents) }
  end
end
