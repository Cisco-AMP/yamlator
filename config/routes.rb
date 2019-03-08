Rails.application.routes.draw do
  get 'yaml_samples/new'
  get 'yaml_samples', to: redirect('/'), status: 302

  resources :yaml_samples

  root 'yaml_samples#new'
end
