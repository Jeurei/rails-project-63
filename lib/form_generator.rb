# frozen_string_literal: true

require_relative 'form_generator/version'

module FormGenerator
  class Error < StandardError; end
  autoload :Tag, File.expand_path('form_generator/tag', __dir__)
end

puts FormGenerator::Tag.new('input', type: 'text', placeholder: 'Enter your name')
puts FormGenerator::Tag.new('br', type: 'text')
