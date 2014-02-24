Submissions::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'site#index'
  get :index, :to => 'site#index', :as => :new_session	

  resources :students, :only => [:index, :show] do
    get :submissions, to: 'students#submissions'
  end
  resources :instructors, :only => [:show]
  resources :submissions

  resources :submissions, :only => [:index]
end
