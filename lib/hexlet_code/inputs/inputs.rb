# frozen_string_literal: true

module HexletCode
  # Create a module Inputs that autoloads the BaseInput, StringInput, and TextInput classes.
  module Inputs
    autoload(:BaseInput, 'hexlet_code/inputs/base_input')
    autoload(:StringInput, 'hexlet_code/inputs/string_input.rb')
    autoload(:TextInput, 'hexlet_code/inputs/text_input.rb')
  end
end
