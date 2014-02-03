Submissions::Application.routes.draw do
  devise_for :instructors
  root to: 'instructors#home'
end
