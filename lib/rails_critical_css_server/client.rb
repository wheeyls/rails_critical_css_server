require 'httparty'

module RailsCriticalCssServer
  class Client
    include HTTParty
    attr_reader :manifest, :key, :url, :token

    NAMESPACE = 'critical-css:'

    def initialize(key, url, manifest, base_uri: Config.host, timeout: Config.timeout, token: Config.auth_token)
      @key = key
      @manifest = manifest
      @url = url
      @token = token
      self.class.base_uri base_uri
      self.class.default_timeout timeout
    end

    def read!
      self.class.post('/api/v1/css',
                      headers: auth.merge(json_headers),
                      body: { page: page_data, config: Config.read_options }.to_json)
    rescue => e
      log_error e
      nil
    end

    def page_data
      { key: full_key, css: manifest, url: url }
    end

    def log_error(error)
      Rails.logger.error error
    end

    private

    def full_key
      "#{NAMESPACE}:#{key}"
    end

    def auth
      {
        'x-access-token' => token
      }
    end

    def json_headers
      { 'Content-Type' => 'application/json' }
    end
  end
end
