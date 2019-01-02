# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'event_representer'
require_relative 'image_representer'

module FantasticProject
  module Representer
    # Represents folder summary about repo's folder
    class EventFull < Roar::Decorator
      include Roar::JSON

      property :event, extend: Representer::Event, class: OpenStruct
      collection :images, extend: Representer::Image, class: OpenStruct
    end
  end
end
