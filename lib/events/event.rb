# frozen_string_literal: false

module FantasticProject
  # Provides access to forecast data
  class Event
    def initialize(event_data)
      @event_data = event_data
    end

    def title
      @event_data['title']
    end

    def description
      @event_data['description']
    end
  end
end
