# frozen_string_literal: true

require 'dry/transaction'

module FantasticProject
  module Service
    # Transaction to store project from Github API to database
    class Event
      include Dry::Transaction

      step :request_events
      step :depresent_events

      private

      def request_events(input)
        input[:response] = Gateway::Api.new(FantasticProject::App.config)
          .individual_event(input[:event_id])

        input[:response].success? ? Success(input) : Failure(response.message)
      rescue StandardError
        Failure('Cannot get events right now; please try again later')
      end

      def depresent_events(input)
        unless input[:response].processing?
          Representer::EventFull.new(OpenStruct.new)
          .from_json(input[:response].payload)
          .yield_self { |event| input[:info] = event }
        end

        Success(input)
      # rescue StandardError
      #  Failure('Error in get event -- please try again')
      end
    end
  end
end
