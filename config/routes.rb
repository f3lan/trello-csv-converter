Rails.application.routes.draw do
  root 'converter#index'
  match 'upload', to: 'converter#upload', via: [:post]


end
