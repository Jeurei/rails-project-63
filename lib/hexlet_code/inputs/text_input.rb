# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    # TextInput class
    class TextInput < BaseInput
      TAG_NAME = 'textarea'
      ROWS = 40
      COLS = 20

      def initialize(args)
        rows = args.fetch(:rows, ROWS)
        cols = args.fetch(:cols, COLS)
        content = args.delete(:value) || ''

        super(args.merge(rows: rows, cols: cols)) { content }
      end
    end
  end
end
