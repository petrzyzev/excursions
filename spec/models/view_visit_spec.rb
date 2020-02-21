# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewVisit, type: :model do
  it 'is not valid' do
    expect(described_class.new).not_to be_valid
  end

  it 'is valid with valid attributes' do
    activity = Activity.new
    expect(activity.view_visits.new).to be_valid
  end

  describe 'Associations' do
    it 'belongs to activity' do
      a = described_class.reflect_on_association(:activity)
      expect(a.macro).to eq(:belongs_to)
    end
  end
end
