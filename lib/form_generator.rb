# frozen_string_literal: true

require_relative 'form_generator/version'

# Form Generator module
module FormGenerator
  class Error < StandardError; end
  autoload :Tag, 'form_generator/tag'

  def self.form_for(struct, args = {})
    args = args.transform_keys(&:to_sym)
    url = args[:url] || '#'
    args.delete(:url)
    end_args = { action: url, method: 'post' }.merge(args)

    form_instance = Form.new(struct, '', end_args)

    yield(form_instance) if block_given?

    form_instance
  end

  # Form Generator class
  class Form
    attr_accessor :content

    def initialize(struct, content = '', args = {})
      @struct = struct
      @content = content
      @args = args
    end

    def input(key, args = {})
      raise NoMethodError, "Key or method `#{key}` not found in the provided struct" unless @struct.respond_to?(key)

      as_tag = args[:as].to_s || 'input'

      args.delete(:as)

      input_tag = if as_tag == 'text'
                    'textarea'
                  else
                    'input'
                  end
      args[:name] = key
      args[:value] = @struct[key] if @struct

      label = FormGenerator::Tag.new('label', for: key) { key.capitalize }
      input = FormGenerator::Tag.new(input_tag, args)
      @content += label.to_s + input.to_s

      input
    end

    def submit(value = 'Save')
      submit = FormGenerator::Tag.new('input', type: 'submit', value: value)

      @content += submit.to_s

      submit
    end

    def to_s
      FormGenerator::Tag.new('form', @args) { @content }.to_s
    end
  end
end
