Submissions::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'site#index'
  get :index, :to => 'site#index', :as => :new_session	

  namespace :instructors do
  	resources :students, :only => [:index, :show]
  	resources :instructors, :only => [:show]
  	resources :submissions
  end

  resources :submissions, :only => [:index]
end
