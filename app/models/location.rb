class Location
  include ActiveModel::Validations
  attr_accessor :lat, :lon

  validates :lat, :lon, numericality: true

  def initialize(lat:, lon:)
    @lat = lat
    @lon = lon
  end
end
