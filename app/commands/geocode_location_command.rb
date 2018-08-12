# frozen_string_literal: true

# Handles the communication with the geocoding service. This command takes
# location query string and returns a Location object. On errors, it returns
# nil and appends various errors.
class GeocodeLocationCommand < BaseCommand
  private

  attr_reader :query

  def initialize(query)
    @query = query
  end

  def payload
    if query.present?
      @result = location if location
    else
      errors.add(:location, 'Invalid query')
    end
  end

  def location
    results = Geocoder.search(query)
    return Location.new(*results.first.coordinates) if results.present?
    errors.add(:location, 'Location not found')
    nil
  rescue SocketError, Timeout::Error, Geocoder::ServiceUnavailable,
         Geocoder::OverQueryLimitError => e
    errors.add(:location, e.message)
    nil
  end
end
