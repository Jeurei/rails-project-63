# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
task default: %i[]

desc 'Run rubocop'
task :lint do
  puts 'Linting...'
  RuboCop::RakeTask.new
end

task :lint_fix do
  puts 'Linting and fixing...'
  RuboCop::RakeTask.new do |task|
    task.options = ['--auto-correct']
  end
end
