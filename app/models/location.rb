# frozen_string_literal: true

# Unpersisted Domain Object that holds latitude and longitude coordinates for a
# location
class Location
  include ActiveModel::Validations
  attr_accessor :lat, :lon

  validates :lat, :lon, numericality: true

  def initialize(lat:, lon:)
    @lat = lat
    @lon = lon
  end
end
