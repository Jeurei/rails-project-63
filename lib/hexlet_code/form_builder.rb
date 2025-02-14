# frozen_string_literal: true

module HexletCode
  # Form builder
  class FormBuilder
    attr_accessor :content, :form_body

    def initialize(entity, **args)
      @entity = entity

      args = args.transform_keys(&:to_sym)

      action = args.fetch(:url, '#')
      method = args.fetch(:method, 'post')

      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: { action: action, method: method }.merge(args.except(:url, :method, :value))
      }
    end

    def input(key, args = {})
      validate_key(key)
      input_tag = determine_input_tag(args)
      args = prepare_attributes(key, args)

      input = input_tag.new(args.except(:as))

      @form_body[:inputs].push(input)
    end

    def submit(value = 'Save')
      @form_body[:submit] = { options: { type: 'submit', value: value } }
    end

    private

    def validate_key(key)
      return if @entity.respond_to?(key)

      raise NoMethodError, "Key or method `#{key}` not found in the provided struct"
    end

    def determine_input_tag(args)
      as_tag = args[:as] || 'string'
      Object.const_get("HexletCode::Inputs::#{as_tag.capitalize}Input")
    end

    def prepare_attributes(key, args)
      args[:name] = key
      args[:value] = @entity[key] if @entity
      args
    end

    def current_scope
      self
    end
  end
end
