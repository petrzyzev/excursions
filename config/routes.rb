# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cities, only: %i[index show]
  resources :activities, only: %i[index show]
  root 'cities#index'
end
