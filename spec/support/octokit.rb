# This support package contains modules for octokit mocking

module OctokitHelper
  def mock_pull_requests_for_org org
     mock_org_repos(org).map do |repo| 
      mock_pull_requests repo 
    end.flatten.group_by do |pull|
      pull.user.login
    end
  end
  def mock_org_repos org
    @repos ||= [
      double('Sawyer::Resource', name: 'repo 1'),
      double('Sawyer::Resource', name: 'repo 2')
    ]
    Octokit::Client.any_instance.stub(:org_repos) { |org=org| @repos }
    @repos
  end
  def mock_pull_requests repo, gh_handle=nil
    @gh_user ||= double('Sawyer::Resource', login: 'fake-gh-handle')
    @gh_repo ||= double('Sawyer::Resource', repo: double('Sawyer::Resource', name: repo))

    @pulls ||= [
      double('Sawyer::Resource', title: 'pr 1', user: @gh_user, head: @gh_repo),
      double('Sawyer::Resource', title: 'pr 2', user: @gh_user, head: @gh_repo)
    ]
    Octokit::Client.any_instance.stub(:pull_requests) { |repo| @pulls }
    @pulls 
  end
end

RSpec.configure do |config|
  config.include OctokitHelper 
end
