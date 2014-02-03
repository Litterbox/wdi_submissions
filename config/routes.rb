Submissions::Application.routes.draw do
  devise_for :users
  root to: 'instructors#home'
end
