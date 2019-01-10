Rails.application.routes.draw do
  get 'yaml_samples/new'

  resources :yaml_samples

  root 'yaml_samples#new'
end
