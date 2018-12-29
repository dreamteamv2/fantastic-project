# frozen_string_literal: true

require_relative 'event'

module Views
  # View for a a list of project entities
  class EventsList
    def initialize(events)
      @events = events.map.with_index { |event, i| Event.new(event, i) }
    end

    def each
      @events.each do |event|
        yield event
      end
    end

    def any?
      @events.any?
    end
  end
end
