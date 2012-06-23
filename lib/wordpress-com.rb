require 'oauth2'

require "wordpress-com/version"
require "wordpress-com/access_token"

class WordpressCom
  extend Forwardable
  attr_reader :client, :token
  def_delegators :@token, :request, :get, :post, :put, :delete

  def initialize(client_id, client_secret, token=nil)
    @client = OAuth2::Client.new(client_id, client_secret,
      :site          => 'https://public-api.wordpress.com/',
      :authorize_url => '/oauth2/authorize',
      :token_url     => '/oauth2/token')
    @token = AccessToken.from_hash(client, token) if token
  end

  def self.deserialize(data)
    self.new(*data)
  end

  def authorize_url(redirect_uri, opts={})
    opts[:redirect_uri] = @redirect_uri = redirect_uri
    client.auth_code.authorize_url(opts)
  end

  def get_token(code, redirect_uri=nil)
    redirect_uri ||= @redirect_uri
    @token = AccessToken.from_hash( @client,
      client.auth_code.get_token(code,
        :redirect_uri => redirect_uri,
        :parse => :json).to_hash)
  end

  def serialize
    [ client.id, client.secret, token.to_hash ]
  end

  def blog_id
    token['blog_id']
  end
end
