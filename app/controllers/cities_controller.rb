# frozen_string_literal: true

class CitiesController < ApplicationController
  before_action :set_city, only: %i[show]

  def index
    join = 'JOIN view_visits ON view_visits.activity_id = activities.id'
    count = 'COUNT(view_visits.id) DESC'
    @cities =
      City.joins(:activities).joins(join).order(count).group(:id).limit(5)
  end

  def show
    activities = @city.activities
    if params[:order] == 'price'
      @activities =
        activities.limit(30).sort { |a, b| b.price.to_i <=> a.price.to_i }
    else
      count = 'COUNT(view_visits.id) DESC'
      @activities =
        activities.left_joins(:view_visits).group(:id).order(count).limit(30)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_city
    @city = City.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def city_params
    params.require(:city).permit(:name)
  end
end
