require 'singleton'
class OctokitWrapper
  include Singleton

  def client
    if ENV['GA_ORG_NAME'].nil? && @client.nil?
      Rails.logger.warn("Please set ENV['GA_ORG_NAME']
       to the github organization which contains your assignments.")
    end
    @client ||= Octokit::Client.new(
      client_id: ENV['GITHUB_APP_ID'],
      client_secret: ENV['GITHUB_APP_SECRET']
    )
  end
end
