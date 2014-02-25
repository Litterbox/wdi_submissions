require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe 'POST /github' do
    before do
      @user = FactoryGirl.create(:instructor)
      @user.stub(:is_instructor?) { true }
      User.stub(:find_for_gh_oauth) { @user }
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :github
    end

    it 'should sign in the user' do
      controller.current_user.should == @user
    end

    it 'should redirect the user' do
      controller.should redirect_to submissions_path
    end

    it 'set the Github success notice' do
      flash[:notice].should == "Successfully authenticated from Github account."
    end
  end
end
