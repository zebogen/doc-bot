Rails.application.routes.draw do
  resources :answers, only: [:create]
end
