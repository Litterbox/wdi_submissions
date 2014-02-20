require 'spec_helper'

describe User do
  describe '.find_for_gh_oauth' do
    context 'user exists' do
      it 'should retun the user' do
        @user = FactoryGirl.create(:student)
        User.find_for_gh_oauth(mock_auth_hash(@user)).should == @user
      end
    end
    context 'user does NOT exist' do
      it 'should create a STUDENT' do
        expect do
          User.find_for_gh_oauth(mock_auth_hash)
        end.to change(User, :count).by(1)
      end

      it 'should return the STUDENT' do
        User.find_for_gh_oauth(mock_auth_hash).should be_a(Student)
      end
    end
    context 'when INSTRUCTOR matching gh handle IS FOUND' do
      it 'should return the instructor record' do
        @instructor = FactoryGirl.create(:instructor)
        User.find_for_gh_oauth(
          mock_auth_hash(@instructor)
        ).id.should ==  @instructor.id
      end
    end
  end
end
