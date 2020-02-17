# frozen_string_literal: true

require 'net/http'
require_relative '../../app/models/city'

namespace :import do
  desc 'Import excursions from Sputnik8'
  task cities: :environment do
    api_key = '164ceb36083462aef1f26c8bf12e1b75'
    username = 'petrzyzevja@yandex.ru'
    resource = 'https://api.sputnik8.com/v1/cities'
    uri = URI(resource)
    request_params = { api_key: api_key, username: username }
    uri.query = URI.encode_www_form(request_params)
    response = Net::HTTP.get_response(uri)
    cities = JSON.parse(response.body, symbolize_names: true)
    City.transaction do
      cities.each do |city|
        uri = URI(resource + "/#{city[:id]}")
        uri.query = URI.encode_www_form(request_params)
        response = Net::HTTP.get_response(uri)
        city_info = JSON.parse(response.body, symbolize_names: true)
        photo = city_info[:geo][:description][:image]
        attrs = { id: city[:id], name: city[:name], photo: photo }
        City.create(attrs)
      end
    end
  end

  task activities: :environment do
    api_key = '164ceb36083462aef1f26c8bf12e1b75'
    username = 'petrzyzevja@yandex.ru'
    resource = 'https://api.sputnik8.com/v1/products'
    uri = URI(resource)
    request_params = { api_key: api_key, username: username }
    uri.query = URI.encode_www_form(request_params)
    response = Net::HTTP.get_response(uri)
    products = JSON.parse(response.body, symbolize_names: true)
    Activity.transaction do
      products.each do |p|
        attrs = { id: p[:id],
                  title: p[:title],
                  description: p[:description],
                  city_id: p[:city_id],
                  price: p[:price],
                  photo: p[:cover_photo][:big] }
        Activity.create(attrs)
      end
    end
  end
end
