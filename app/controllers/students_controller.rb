class StudentsController < BaseController
  def submissions
    @octokit = OctokitWrapper.instance.client
    @submissions = @octokit.org_repos(ENV['GA_ORG_NAME']).map do |repo|
      @octokit.pull_requests("#{ENV['GA_ORG_NAME']}/#{repo.name}")
    end.flatten
  end
end
