require 'spec_helper'

describe User do
  describe '.find_for_gh_oauth' do
    before do
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'github',
        uid: '123545',
        info: {
          name: 'github user',
          image: 'gravatar image',
          nickname: 'gh-nickname'
        } 
      })
      @auth_hash = OmniAuth.config.mock_auth[:github] 
    end
    context 'user exists' do
      it 'should retun the user' do
        @user = FactoryGirl.create(:user, uid: 123545, user_type: 'any')
        User.find_for_gh_oauth(@auth_hash).should == @user
      end
    end
    context 'user does NOT exist' do
      it 'should create a STUDENT' do
        User.find_for_gh_oauth(@auth_hash).user_type.should == 'student'
      end
    end
    context 'when INSTRUCTOR matching gh handle IS FOUND' do
      it 'should return the instructor record' do
        @instructor = FactoryGirl.create(:instructor, uid: 123545)
        User.find_for_gh_oauth(@auth_hash).id.should ==  @instructor.id
      end
    end
  end
end
