Rails.application.routes.draw do
  root 'questions#index'
  resources :questions, only: [:index]
  post 'questions/check_answers', to: 'questions#check_answers'
end