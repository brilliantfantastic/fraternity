begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new
