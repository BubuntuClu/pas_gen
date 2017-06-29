Rails.application.routes.draw do
  root 'main#index'
  get 'generate', to: 'main#generate'
end
