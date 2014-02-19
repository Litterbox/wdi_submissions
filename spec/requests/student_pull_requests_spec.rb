describe "Student pull requests" do
  describe "GET /students/pull_requests" do
    it "displays the pull requests" do
      sign_in_as_a_valid_instructor
      @student = FactoryGirl.create(:student, squad_leader_id: @instructor)
      get student_pull_requests_path(@student.id)
    end
  end
end
