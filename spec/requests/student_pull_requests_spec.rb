require 'spec_helper'

describe "Student pull requests" do
  describe "GET /students/submissions" do
    it "displays the submissions" do
      sign_in_as_a_valid_instructor
      @student = FactoryGirl.create(:student, squad_leader_id: @instructor)
      pull_requests = mock_pull_requests
      get student_submissions_path(@student.id)
      pull_requests.each do |pr|
        response.body.should include(pr.title)
      end
    end
  end
end
