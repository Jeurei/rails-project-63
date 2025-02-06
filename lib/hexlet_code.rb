# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form Builder module
module HexletCode
  class Error < StandardError; end
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :FormRenderer, 'hexlet_code/form_renderer'

  # rubocop:disable Lint/Syntax
  def self.form_for(entity, args = {}, &block)
    HexletCode::FormBuilder.form_for(entity, args, &block)
  end
  # rubocop:enable Lint/Syntax

  # Form Generator class
end
