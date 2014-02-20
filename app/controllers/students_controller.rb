class StudentsController < BaseController
  def submissions
    @submissions = Octokit.org_repos(ENV['GA_ORG_NAME']).map do |repo|
      Octokit.pull_requests("#{ENV['GA_ORG_NAME']}/#{repo.name}")
    end.flatten
  end
end
