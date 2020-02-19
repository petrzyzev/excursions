# frozen_string_literal: true

class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show]

  def index
    @activities = Activity.all
  end

  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def activity_params
    params.require(:activity).permit(:title, :description, :price)
  end
end
