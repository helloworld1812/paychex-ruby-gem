require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |task|
  # TODO: Check if following options work properly or not
  task.rspec_opts = ["--color", "--format", "nested"]
  task.verbose = false
end

task :default => :spec
