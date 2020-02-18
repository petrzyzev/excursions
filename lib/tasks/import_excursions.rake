# frozen_string_literal: true

namespace :import do
  desc 'Import excursions from Sputnik8'
  task cities: :environment do
    api_key = ENV['SPUTNIK_API_KEY']
    username = ENV['SPUTNIK_USERNAME']
    resource = ENV['SPUTNIK_CITIES_URI']
    uri = URI(resource)
    request_params = { api_key: api_key, username: username }
    uri.query = URI.encode_www_form(request_params)
    response = Net::HTTP.get_response(uri)
    cities = JSON.parse(response.body, symbolize_names: true)
    cities_attrs = cities.map do |city|
      uri = URI(resource + "/#{city[:id]}")
      uri.query = URI.encode_www_form(request_params)
      response = Net::HTTP.get_response(uri)
      city_info = JSON.parse(response.body, symbolize_names: true)
      photo = city_info[:geo][:description][:image]
      { id: city[:id], name: city[:name], photo: photo }
    end

    City.transaction do
      City.create(cities_attrs)
    end
  end

  task activities: :environment do
    api_key = ENV['SPUTNIK_API_KEY']
    username = ENV['SPUTNIK_USERNAME']
    resource = ENV['SPUTNIK_PRODUCTS_URI']
    uri = URI(resource)
    request_params = { api_key: api_key, username: username }
    uri.query = URI.encode_www_form(request_params)
    response = Net::HTTP.get_response(uri)
    products = JSON.parse(response.body, symbolize_names: true)
    activities_attrs = products.map do |p|
      { id:          p[:id],
        title:       p[:title],
        description: p[:description],
        city_id:     p[:city_id],
        price:       p[:price],
        photo:       p[:cover_photo][:big] }
    end

    Activity.transaction do
      Activity.create(activities_attrs)
    end
  end
end
