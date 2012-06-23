require "oauth2"

class OAuth2::AccessToken
  # Returns serialization of the token as a Hash
  def to_hash
    rv = { :access_token => token }
    rv[:refresh_token] = refresh_token if refresh_token
    rv[:expires_in] = expires_in if expires_in
    rv[:expires_at] = expires_at if expires_at
    rv[:mode] = options[:mode] if options[:mode] != :header
    rv[:header_format] = options[:header_format] if options[:header_format] != 'Bearer %s'
    rv[:param_name] = options[:param_name] if options[:param_name] != 'bearer_token'
    rv.merge(params)
  end
end

class WordpressCom
  class AccessToken < OAuth2::AccessToken
    def request(verb, path, opts={}, &block)
      full_path = "/rest/v1/"
      full_path << "sites/#{self['blog_id']}/" unless opts.delete('root_path')
      full_path << path.gsub(/^\/*/, '')
      super(verb, full_path, opts, &block)
    end
  end
end
