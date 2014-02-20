# This support package contains modules for octokit mocking

module OctokitHelper
  def mock_pull_requests repo, gh_handle=nil
    pulls = [
      double('Sawyer::Resource', title: 'pr 1'),
      double('Sawyer::Resource', title: 'pr 2')
    ]
    Octokit.stub(:pull_requests) { |repo| pulls }
    Octokit.pull_requests
  end
end

RSpec.configure do |config|
  config.include OctokitHelper 
end
