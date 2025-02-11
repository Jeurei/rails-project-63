# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # StringInput#
    class StringInput < BaseInput
      TAG_NAME = 'input'

      def initialize(args)
        super(args.merge(type: 'text'))
      end
    end
  end
end
