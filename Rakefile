# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# https://stackoverflow.com/questions/35893584/nomethoderror-undefined-method-last-comment-after-upgrading-to-rake-11
 # temp fix for NoMethodError: undefined method `last_comment'
 # remove when fixed in Rake 11.x
 module TempFixForRakeLastComment
   def last_comment
     last_description
   end
 end
 Rake::Application.send :include, TempFixForRakeLastComment
 ### end of temfix


require File.expand_path('../config/application', __FILE__)
require 'rspec/core/rake_task'
Sup::Application.load_tasks
RSpec::Core::RakeTask.new(:spec)
# Exclude slow tests
RSpec::Core::RakeTask.new(:fspec) do |t|
  t.rspec_opts = '--tag ~speed:slow'
end

desc 'Run RuboCop'
task :rubocop do
  sh 'bundle exec rubocop'
end

task default: [:rubocop, :spec]
