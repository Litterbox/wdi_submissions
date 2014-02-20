class StudentsController < BaseController
  def submissions
    @submissions = Octokit.pull_requests 'repo'
  end
end
