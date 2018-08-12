# frozen_string_literal: true

module Api
  module V1
    class LocationsController < ApplicationController
      def index
        location = LocationLookupService.find(query: query_param)
        render json: LocationSerializer.new(location),
               content_type: CONTENT_TYPE
      rescue NotFoundError
        render_error(status: 404,
                     title: 'Not Found',
                     message: 'The specified location could not be found')
      end

      private

      def query_param
        params.require(:query)
      end
    end
  end
end
