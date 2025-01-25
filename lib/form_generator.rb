# frozen_string_literal: true

require_relative 'form_generator/version'

# FormGenerator module
module FormGenerator
  class Error < StandardError; end
  autoload :Tag, 'form_generator/tag'

  def self.form_for(_, args = {})
    args = args.transform_keys(&:to_sym)
    url = args[:url] || '#'
    args.delete(:url)

    args_string = args.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')

    "<form action=\"#{url}\" method=\"post\"#{args_string.empty? ? '' : " #{args_string}"}></form>"
  end
end
