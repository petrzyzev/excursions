# frozen_string_literal: true

FactoryBot.define do
  factory :city, class: 'City' do
    name { 'name' }
    photo { 'photo' }
  end
end
