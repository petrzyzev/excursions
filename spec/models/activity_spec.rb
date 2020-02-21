# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'is not valid' do
    expect(described_class.new).not_to be_valid
  end

  it 'is valid with valid attributes' do
    city = City.new
    expect(city.activities.new).to be_valid
  end

  describe 'Associations' do
    it 'belongs to city' do
      a = described_class.reflect_on_association(:city)
      expect(a.macro).to eq(:belongs_to)
    end

    it 'have many view_visits' do
      a = described_class.reflect_on_association(:view_visits)
      expect(a.macro).to eq(:has_many)
    end
  end
end
