# frozen_string_literal: true

require 'dry/transaction'

module FantasticProject
  module Service
    # Transaction to store project from Github API to database
    class EventList
      include Dry::Transaction

      step :request_events
      step :depresent_events

      private

      def request_events(input)
        result = Gateway::Api.new(FantasticProject::App.config)
          .search_event(input[:category], input[:country])
        result.success? ? Success(result.payload) : Failure(result.message)
      end

      def depresent_events(json_data)
        Representer::EventsList.new(OpenStruct.new)
          .from_json(json_data)
          .yield_self { |events| Success(events) }
      rescue StandardError
        Failure('Could not parse response from API')
      end
    end
  end
end
