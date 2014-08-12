Rails.application.routes.draw do
  resources :enquiries
  root 'enquiries#new'
end
