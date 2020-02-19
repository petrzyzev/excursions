# frozen_string_literal: true

require 'tsv'

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
    activities_attrs = products.map do |product|
      { id: product[:id],
        title: product[:title],
        description: product[:description],
        city_id: product[:city_id],
        price: product[:price],
        photo: product[:cover_photo][:big] }
    end

    Activity.transaction do
      Activity.create(activities_attrs)
    end
  end
  task views: :environment do
    filenames = ['views-1.tsv', 'views-2.tsv', 'views-3.tsv']
    attrs = filenames.map do |filename|
      TSV[filename].map do |row|
        view_id, visit_id, activ_id = row.data.map(&:to_i)
        { view_id: view_id, visit_id: visit_id, activity_id: activ_id }
      end
    end

    ViewVisit.transaction do
      ViewVisit.create(attrs.flatten)
    end
  end
end
