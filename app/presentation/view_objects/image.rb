# frozen_string_literal: true

module Views
  # View for a single project entity
  class Image
    def initialize(image, index = nil)
      @image = image
      @index = index
    end

    def entity
      @image
    end

    def url
      @image.url
    end
  end
end
