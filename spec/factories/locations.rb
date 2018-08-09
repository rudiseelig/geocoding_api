FactoryBot.define do
  factory :location do
    lat 1.5
    lon 1.5

    skip_create

    initialize_with do
      new(lat: lat, lon: lon)
    end
  end
end