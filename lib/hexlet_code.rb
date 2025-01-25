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
      raise NoMethodError, "Key or method `#{key}` not found in the provided struct" unless @struct.respond_to?(key)

      as_tag = args[:as].to_s || 'input'

      args.delete(:as)

      input_tag = if as_tag == 'text'
                    'textarea'
                  else
                    'input'
                  end
      args[:name] = key
      args[:value] = @struct[key] if @struct && input_tag == 'input'

      args[:type] = 'text' if input_tag == 'input'

      label = HexletCode::Tag.new('label', for: key) { key.capitalize }
      input = HexletCode::Tag.new(input_tag, args) { input_tag == 'input' ? '' : @struct[key] }
      @content += label.to_s + input.to_s

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
  end
end
