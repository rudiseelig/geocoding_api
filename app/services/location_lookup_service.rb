# frozen_string_literal: true

class NotFoundError < StandardError; end

class LocationLookupService
  def self.find(query:)
    new(query).find
  end

  def initialize(query)
    @query = query
  end

  def find
    results = Geocoder.search(@query)
    raise NotFoundError if results.empty?
    lat, lon = results.first.coordinates
    Location.new(lat: lat, lon: lon)
  end
end
