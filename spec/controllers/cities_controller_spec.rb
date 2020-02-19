require 'rails_helper'

RSpec.describe CitiesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # City. As you add validations to City, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET #index" do
    it "returns a success response" do
      City.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      city = City.create! valid_attributes
      get :show, params: {id: city.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end
end
