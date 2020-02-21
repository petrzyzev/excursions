# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :city
  has_many :view_visits
end
