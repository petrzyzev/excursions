# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cities
  resources :activities
  root 'cities#index'
end
