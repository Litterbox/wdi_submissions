require 'spec_helper'

describe "Student pull requests" do
  describe "GET /students/submissions" do
    it "displays the submissions" do
      sign_in_as_a_valid_instructor
      @student = FactoryGirl.create(:student, squad_leader_id: @instructor)
      get student_submissions_path(@student.id)
    end
  end
end
