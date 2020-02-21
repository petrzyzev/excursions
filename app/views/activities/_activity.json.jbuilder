# frozen_string_literal: true

json.extract! activity, :id, :title, :description, :price, :created_at, :updated_at
json.url activity_url(activity, format: :json)
