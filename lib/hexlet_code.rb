# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form Generator module
module HexletCode
  class Error < StandardError; end
  autoload :Tag, 'hexlet_code/tag'

  def self.form_for(struct, args = {})
    args = args.transform_keys(&:to_sym)
    url = args[:url] || '#'

    args.delete(:url)

    method = args[:method] || 'post'

    args.delete(:method)

    end_args = { action: url, method: method }.merge(args)

    form_instance = Form.new(struct, '', end_args)

    yield(form_instance) if block_given?

    form_instance.to_s
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
      validate_key(key)

      input_tag = determine_input_tag(args)
      args = prepare_attributes(key, args, input_tag)

      label = build_label(key)
      input = build_input(input_tag, key, args)

      @content += label + input
      input
    end

    def submit(value = 'Save')
      submit = HexletCode::Tag.new('input', type: 'submit', value: value)

      @content += submit.to_s

      submit
    end

    def current_scope
      self
    end

    def to_html
      to_s
    end

    def to_s
      HexletCode::Tag.new('form', @args) { @content }.to_s
    end

    private

    def validate_key(key)
      return if @struct.respond_to?(key)

      raise NoMethodError, "Key or method `#{key}` not found in the provided struct"
    end

    def determine_input_tag(args)
      as_tag = args.delete(:as) || 'input'
      as_tag.to_s == 'text' ? 'textarea' : 'input'
    end

    def prepare_attributes(key, args, input_tag)
      args[:name] = key
      args[:value] = @struct[key] if @struct && input_tag == 'input'
      args[:type] = 'text' if input_tag == 'input'
      args
    end

    def build_label(key)
      HexletCode::Tag.new('label', for: key) { key.capitalize }.to_s
    end

    def build_input(input_tag, key, args)
      content = input_tag == 'textarea' ? @struct[key] : ''
      HexletCode::Tag.new(input_tag, args) { content }.to_s
    end
  end
end
