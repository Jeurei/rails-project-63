# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form Builder module
module HexletCode
  class Error < StandardError; end
  autoload :Tag, 'hexlet_code/tag'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :FormRenderer, 'hexlet_code/form_renderer'

  def self.form_for(entity, args = {}, &)
    HexletCode::FormBuilder.form_for(entity, args, &)
  end

  # Form Generator class
end
