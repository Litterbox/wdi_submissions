require 'spec_helper'

describe StudentsController do
  describe 'GET #submissions' do
    before do
      @user = FactoryGirl.create(:instructor)
      @user.stub(:is_instructor?) { true }
      @submissions = mock_pull_requests 'repo'
      controller.stub(:current_user) { @user }
    end
    it 'assigns @submissions' do
      get :submissions, student_id: 2
      assigns(:submissions).should == @submissions
    end
    it 'renders pull requests template' do
      get :submissions, student_id: 2
      response.should render_template 'submissions'
    end
  end
end
