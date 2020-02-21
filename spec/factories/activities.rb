# frozen_string_literal: true

FactoryBot.define do
  factory :activity, class: 'Activity' do
    title { 'titile' }
    description { 'description' }
    photo { 'photo' }
    price { '100$' }

    association :city
  end
end
