require 'singleton'
class OctokitWrapper
  include Singleton

  def client
    @client ||= Octokit::Client.new(
      client_id: ENV['GITHUB_APP_ID'],
      client_secret: ENV['GITHUB_APP_SECRET']
    )
  end
end
