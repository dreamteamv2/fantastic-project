# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'
require_relative 'helpers.rb'

module FantasticProject
  # Web App
  class App < Roda
    include RouteHelpers

    plugin :halt
    plugin :flash
    plugin :all_verbs
    plugin :render, engine: 'slim', views: 'app/presentation/views'
    plugin :assets, path: 'app/presentation/assets',
                    css: ['bootstrap.min.css', 'simple-line-icons.css',
                          'themify-icons.css', 'set1.css', 'style.css'],
                    js: ['jquery-3.2.1.min.js']

    plugin :public, root: './app/presentation/static'

    use Rack::MethodOverride

    # rubocop:disable Metrics/BlockLength
    # rubocop:disable Style/ConditionalAssignment
    route do |routing|
      routing.public
      routing.assets # load CSS

      # GET /
      routing.root do
        session[:watching] ||= []
        if session[:watching][0]
          country = session[:watching][0][:country]
        else
          country = 'canada'
        end
        view 'home', locals: { country: country }
      end

      routing.on 'events' do
        routing.is do
          # POST /event/
          routing.post do
            form_request = Forms::SearchEvents.call(routing.params)
            search_info = Service::SearchEvents.new.call(form_request)

            if search_info.failure?
              flash[:error] = search_info.failure
              routing.redirect '/'
            end

            search_info = search_info.value!
            cookie_data = {
              country: search_info[:country],
              category: search_info[:category]
            }

            session[:watching].insert(0, cookie_data).uniq!
            category = search_info[:category]
            country = search_info[:country]

            res_url = "events/#{category}/#{country}"
            routing.redirect res_url
          end
        end

        routing.on String, String do |category, country|
          # GET /events/{category}/{country}
          routing.get do
            path_request = EventRequestPath.new(
              category, country
            )
            session[:watching] ||= []

            result = Service::EventList.new.call(
              country: path_request.country,
              category: path_request.category
            )

            events = []
            if result.failure?
              flash[:error] = result.failure
              routing.redirect '/'
            else
              events = result.value!.events
              if events.none?
                flash.now[:notice] = 'No events with that parameters'
                routing.redirect '/'
              end
            end

            # Show events
            events = Views::EventsList.new(events)
            view 'events', locals: { events: events, 
                                     category: path_request.category }
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength
    # rubocop:enable Style/BlockComments
  end
end
