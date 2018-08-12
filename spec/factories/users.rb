# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'test@example.com'
    password_digest 'secure'
  end
end
