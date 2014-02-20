class StudentsController < BaseController
  def submissions
    @submissions = Octokit.pull_requests
  end
end
