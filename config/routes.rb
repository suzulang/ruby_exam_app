Rails.application.routes.draw do
  resources :questions, only: [:index]
  post 'questions/check_answers', to: 'questions#check_answers'
end