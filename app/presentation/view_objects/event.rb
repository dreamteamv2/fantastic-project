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

    def id
      @event.id
    end

    def description
      if @event.description.empty?
        'No description available.
         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
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
