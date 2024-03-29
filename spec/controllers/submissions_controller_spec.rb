require 'spec_helper'

describe SubmissionsController do
  describe 'GET #submissions' do
    before do
      @user = FactoryGirl.create(:instructor)
      @user.stub(:is_instructor?) { true }
      @submissions = mock_pull_requests_for_org ENV['GA_ORG_NAME']
      controller.stub(:current_user) { @user }
      get :index
    end
    it 'assigns @submissions' do
      assigns(:submissions).should == @submissions
    end
    it 'renders pull requests template' do
      response.should render_template 'index'
    end
  end
end
