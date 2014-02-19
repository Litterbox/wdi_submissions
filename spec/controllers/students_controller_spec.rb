require 'spec_helper'

describe StudentsController do
  describe 'GET #pull_requests' do
    it 'assigns @pull_requests' do
      @user = FactoryGirl.create(:instructor)
      @user.stub(:is_instructor?) { true }
      controller.stub(:current_user) { @user }

      get :pull_requests, student_id: 2
      assigns(:pull_requests).should == []
    end
    it 'renders pull requests template' do
      get :pull_requests, student_id: 2
      response.should render_template 'pull_requests'
    end
  end
end
