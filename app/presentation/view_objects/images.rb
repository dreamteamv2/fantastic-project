# frozen_string_literal: true

require_relative 'image'

module Views
  # View for a a list of project entities
  class Images
    def initialize(images)
      @images = images.map.with_index { |image, i| Image.new(image, i) }
    end

    def each
      @images.each do |image|
        yield image
      end
    end

    def any?
      @images.any?
    end
  end
end
