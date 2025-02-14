# frozen_string_literal: true

require_relative '../tag'

module HexletCode
  module Inputs
    # BaseInput class
    class BaseInput
      def initialize(args)
        raise NotImplementedError, "#{self.class} must define TAG_NAME" unless defined?(self.class::TAG_NAME)

        @label = HexletCode::Tag.new('label', for: args[:name]) { args[:name].capitalize }
        @tag = Tag.new(self.class::TAG_NAME, args) { yield if block_given? }
      end

      def to_s
        "#{@label}\n  #{@tag}"
      end
    end
  end
end
