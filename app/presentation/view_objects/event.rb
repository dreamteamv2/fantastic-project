# frozen_string_literal: true

module Views
  # View for a single project entity
  class Event
    def initialize(event, index = nil)
      @event = event
      @index = index
    end

    def entity
      @event
    end

    def praise_link
      "/event/#{@event.id}"
    end

    def title
      @event.title
    end

    def description
      if @event.description.empty?
        'No description available'
      else
        @event.description
      end
    end

    def country
      @event.country_code
    end

    def category
      @event.category
    end
  end
end
