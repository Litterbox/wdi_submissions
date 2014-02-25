# This support package contains modules for octokit mocking

module OctokitHelper
  def mock_pull_requests_for_org org
     mock_org_repos(org).map do |repo| 
      mock_pull_requests repo 
    end.flatten.group_by do |pull|
      pull.head.user
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
    @pull_head ||= double(
      'Sawyer::Resource', 
      user: double('Sawyer::Resource', login: 'fake-gh-handle')
    )
    @pulls ||= [
      double('Sawyer::Resource', title: 'pr 1', head: @pull_head),
      double('Sawyer::Resource', title: 'pr 2', head: @pull_head)
    ]
    Octokit::Client.any_instance.stub(:pull_requests) { |repo| @pulls }
    @pulls 
  end
end

RSpec.configure do |config|
  config.include OctokitHelper 
end
