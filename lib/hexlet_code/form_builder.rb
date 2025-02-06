# frozen_string_literal: true

require_relative 'form_element_builder'
require_relative 'form_renderer'

module HexletCode
  # Form builder
  class FormBuilder
    attr_accessor :content, :form_body

    include FormElementBuilder

    def initialize(entity, args = {})
      @entity = entity

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: prepare_form_attributes(args)
      }
    end

    def self.form_for(entity, args = {})
      form_instance = FormBuilder.new(entity, **args)

      yield(form_instance) if block_given?

      FormRenderer.render_html(form_instance)
    end

    def current_scope
      self
    end

    private

    def prepare_form_attributes(args)
      args = args.transform_keys(&:to_sym)

      url = args.fetch(:url, '#')

      args.delete(:url)

      method = args.fetch(:method, 'post')

      args.delete(:method)

      { action: url, method: method }.merge(args)
    end
  end
end
