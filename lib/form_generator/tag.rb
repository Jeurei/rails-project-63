# frozen_string_literal: true

module FormGenerator
  # Create a class Tag that receives a tag and a hash of arguments.
  class Tag
    def self.self_closing_tags
      %w[area base br col command embed hr img input keygen link meta param source track wbr]
    end

    def initialize(tag, args = {})
      @tag = tag.to_s
      @args = args
      args_string = args.to_a.reduce('') { |acc, (key, value)| acc + "#{key}=\"#{value}\" " }.strip

      content = block_given? ? yield : ''
      @is_self_closing = Tag.self_closing_tags.include?(@tag)

      @raw_tag = if @is_self_closing
                   "<#{@tag}#{args_string ?   " #{args_string}" : ''} />"
                 else
                   "<#{@tag}#{args_string ? " #{args_string}" : ''}>#{content}</#{tag}>"
                 end
    end

    def self_closing?
      @is_self_closing
    end

    def to_s
      @raw_tag
    end
  end
end
