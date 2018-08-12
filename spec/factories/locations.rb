# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    lat 1.5
    lon 1.5

    skip_create

    initialize_with do
      new(lat, lon)
    end
  end
end
