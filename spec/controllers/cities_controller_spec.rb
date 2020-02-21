# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      FactoryBot.create(:city)
      FactoryBot.create(:city)
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      city = FactoryBot.create(:city)
      get :show, params: { id: city.to_param }
      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end
end
