# frozen_string_literal: true

# Form Element Builder
module FormElementBuilder
  def input(key, args = {})
    validate_key(key)

    input_tag = determine_input_tag(args)
    args = prepare_attributes(key, args, input_tag)

    label = build_label(key)
    input = build_input(input_tag, key, args)

    @form_body[:inputs].push("\n#{label}\n#{input}")
  end

  def submit(value = 'Save')
    @form_body[:submit] = { options: { type: 'submit', value: value } }
  end

  private

  def validate_key(key)
    return if @entity.respond_to?(key)

    raise NoMethodError, "Key or method `#{key}` not found in the provided struct"
  end

  def build_label(key)
    "  #{HexletCode::Tag.new('label', for: key) { key.capitalize }}"
  end

  def build_input(input_tag, key, args)
    content = input_tag == 'textarea' ? @entity[key] : ''
    "  #{HexletCode::Tag.new(input_tag, args) { content }}"
  end

  def determine_input_tag(args)
    as_tag = args.delete(:as) || 'input'
    as_tag.to_s == 'text' ? 'textarea' : 'input'
  end

  def prepare_attributes(key, args, input_tag)
    args[:name] = key
    args[:value] = @entity[key] if @entity && input_tag == 'input'
    args[:type] = 'text' if input_tag == 'input'
    args
  end
end
