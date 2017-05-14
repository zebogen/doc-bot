Rails.application.routes.draw do
  resources :consultations, only: [:create]
  resources :answers, only: [:create]
end
