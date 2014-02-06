class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.find_for_gh_oauth request.env["omniauth.auth"]
    #instructor = Instructor.where(:github_username =>
   	sign_in_and_redirect user, :event => :authentication
   	set_flash_message(:notice, :success, :kind => "Github")
  end
end
