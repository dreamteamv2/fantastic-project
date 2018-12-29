# frozen_string_literal: true

require 'dry/transaction'

module FantasticProject
  module Service
    # Transaction to store project from Github API to database
    class SearchEvents
      include Dry::Transaction

      step :check_fields

      private

      # :reek:NilCheck
      def check_fields(input)
        if input.success?
          Success(country: input[:country],
                  category: input[:category])
        else
          Failure(input.errors.values.join('; '))
        end
      end
    end
  end
end
