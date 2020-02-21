# frozen_string_literal: true

FactoryBot.define do
  factory :view_visit, class: 'ViewVisit' do
    view_id { 1 }
    visit_id { 1 }

    association :activity
  end
end
