# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  describe 'GET #show' do
    it 'returns a success response' do
      activity = FactoryBot.create(:activity)
      get :show, params: { id: activity.to_param }
      expect(response).to be_successful
      expect(response).to render_template('show')
    end
  end
end
