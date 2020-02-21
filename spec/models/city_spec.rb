# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  subject { described_class.new(name: 'name', photo: 'url') }

  it 'is valid with valid attributes' do
    expect(described_class.new).to be_valid
  end

  describe 'Associations' do
    it 'have many activities' do
      c = described_class.reflect_on_association(:activities)
      expect(c.macro).to eq(:has_many)
    end
  end
end
