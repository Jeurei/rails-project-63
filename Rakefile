# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rake/testtask'

task default: %i[]

desc 'Run rubocop'
task :lint do
  puts 'Linting...'
  RuboCop::RakeTask.new
end

desc 'Run lint and fix'
task :lint_fix do
  puts 'Linting and fixing...'
  RuboCop::RakeTask.new do |task|
    task.options = ['--autocorrect']
  end
end

desc 'Run unit tests'
task :test do
  puts 'Testing...'
  Rake::TestTask.new(:test) do |t|
    t.libs << 'lib'
    t.libs << 'test'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = true
  end
end
