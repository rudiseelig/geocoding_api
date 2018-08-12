# frozen_string_literal: true

module Api
  module V1
    class LocationsController < ApplicationController
      def index
        location = GeocodeLocationCommand.call(query_param)
        if location.success?
          render json: { location: location.result }
        else
          render json: { error: location.errors }
        end
      end

      private

      def query_param
        params.require(:query)
      end
    end
  end
end
