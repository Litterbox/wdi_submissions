class SubmissionsController < BaseController
  def index
    @octokit = OctokitWrapper.instance.client
    @submissions = @octokit.org_repos(ENV['GA_ORG_NAME']).map do |repo|
      @octokit.pull_requests("#{ENV['GA_ORG_NAME']}/#{repo.name}")
    end.flatten.group_by do |pull|
      pull.head.user.login
    end
  end
end
