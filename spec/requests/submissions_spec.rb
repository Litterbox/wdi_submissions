require 'spec_helper'

describe "Student pull requests" do
  describe "GET /students/submissions" do
    it "displays the submissions" do
      sign_in_as_a_valid_instructor
      @student = FactoryGirl.create(:student, squad_leader_id: @instructor)
      submissions = mock_pull_requests_for_org 'org'
      get submissions_path 
      submissions.each do |user,subs|
        subs.each do |sub|
          response.body.should include(sub.title)
        end
      end
    end
  end
end
