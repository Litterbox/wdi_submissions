# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_instructor
    @instructor = FactoryGirl.create(:instructor) 

    OmniAuth.config.mock_auth[:github] = {
      provider: @instructor.provider,
      uid: @instructor.uid,
      info: {
        name: @instructor.name,
        image: 'gravatar image',
        nickname: @instructor.gh_nickname 
      } 
    }

    get user_omniauth_callback_path(:github), format: :json
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include ValidUserRequestHelper, :type => :request 
end

OmniAuth.config.test_mode = true
