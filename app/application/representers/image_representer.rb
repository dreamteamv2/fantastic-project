# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module FantasticProject
  module Representer
    # Represent a Image entity as Json
    class Image < Roar::Decorator
      include Roar::JSON

      property :url
      
    end
  end
end
