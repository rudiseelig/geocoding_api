# frozen_string_literal: true

class LocationSerializer
  include FastJsonapi::ObjectSerializer

  set_id :object_id
  set_type :location
  attribute :lat
  attribute :lon
end
