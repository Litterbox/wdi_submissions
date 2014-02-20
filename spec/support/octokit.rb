# This support package contains modules for octokit mocking

module OctokitHelper
  def mock_pull_requests_for_org org
     mock_org_repos(org).map do |repo| 
      mock_pull_requests repo 
    end.flatten
  end
  def mock_org_repos org
    @repos ||= [
      double('Sawyer::Resource', name: 'repo 1'),
      double('Sawyer::Resource', name: 'repo 2')
    ]
    Octokit.stub(:org_repos) { |org=org| @repos }
    @repos
  end
  def mock_pull_requests repo, gh_handle=nil
    @pulls ||= [
      double('Sawyer::Resource', title: 'pr 1'),
      double('Sawyer::Resource', title: 'pr 2')
    ]
    Octokit.stub(:pull_requests) { |repo| @pulls }
    @pulls 
  end
end

RSpec.configure do |config|
  config.include OctokitHelper 
end
