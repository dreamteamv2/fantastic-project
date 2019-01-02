# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module FantasticProject
  module Representer
    # Represent a Event entity as Json
    class Event < Roar::Decorator
      include Roar::JSON

      property :id
      property :origin_id
      property :title
      property :description
      property :category
      property :country_code

      private

      def id
        represented.id
      end
    end
  end
end
