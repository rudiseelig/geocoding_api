# frozen_string_literal: true

Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'example street', [
    {
      'coordinates' => [1.5, 1.5]
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  'nonsense gibberish', []
)
