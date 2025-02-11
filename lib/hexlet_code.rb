# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form Builder module
module HexletCode
  class Error < StandardError; end
  autoload :Tag, 'hexlet_code/tag'
  autoload :Inputs, 'hexlet_code/inputs/inputs'
  autoload :FormBuilder, 'hexlet_code/form_builder'
  autoload :FormRenderer, 'hexlet_code/form_renderer'

  def self.form_for(entity, args = {})
    form_instance = HexletCode::FormBuilder.new(entity, **args)

    yield(form_instance) if block_given?

    HexletCode::FormRenderer.render_html(form_instance)
  end
end
