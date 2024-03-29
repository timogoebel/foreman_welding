# frozen_string_literal: true

require 'rake/testtask'

# Tests
namespace :test do
  desc 'Test ForemanWelding'
  Rake::TestTask.new(:foreman_welding) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_welding do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_welding) do |task|
        task.patterns = ["#{ForemanWelding::Engine.root}/app/**/*.rb",
                         "#{ForemanWelding::Engine.root}/lib/**/*.rb",
                         "#{ForemanWelding::Engine.root}/test/**/*.rb"]
      end
    rescue StandardError
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_welding'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_welding']

load 'tasks/jenkins.rake'
Rake::Task['jenkins:unit'].enhance ['test:foreman_welding', 'foreman_welding:rubocop'] if Rake::Task.task_defined?(:'jenkins:unit')
