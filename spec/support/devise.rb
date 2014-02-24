# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
  def mock_auth_hash user_object=FactoryGirl.build(:user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: user_object.provider,
      uid: user_object.uid,
      info: {
        name: user_object.name,
        image: 'gravatar image',
        nickname: user_object.gh_nickname
      } 
    })
  end

  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_instructor
    @instructor = FactoryGirl.create(:instructor) 

    mock_auth_hash @instructor

    get user_omniauth_callback_path(:github), format: :json
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ValidUserRequestHelper
end

OmniAuth.config.test_mode = true
