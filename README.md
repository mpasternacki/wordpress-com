# Wordpress::Com

Library to access WordPress.com's REST API

https://developer.wordpress.com/

## Installation

Add this line to your application's Gemfile:

    gem 'wordpress-com'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wordpress-com

## Usage

To authorize your token, register your application at
https://developers.wordpress.com/. Make sure that redirect URL is
yours - user will be redirected there, and it has to match. Then do this:

    require 'wordpress-com'
    wpc = WordpressCom.new(client_id, client_secret)
    url = wpc.authorize(redirect_uri)
    # or: wpc.authorize(redirect_uri, :blog => 'http://foobar.wordpress.com/')

Make your user redirect to the returned `url`. User will be redirected
to the `redirect_url` and given a `code` GET parameter. Use this
parameter to obtain a token:

    wpc = WordpressCom.new(client_id, client_secret)
    wpc.get_token(code, redirect_uri)

You can then save complete authorization data, store it somewhere, and
reuse it later on. The authorization data is JSON and YAML safe.

    wordpress_auth = wpc.serialize
    
    wpc = WordPressCom.deserialize(wordpress_auth)

If you are writing a desktop or headless application and want to just
have the authorization data without any hassle, you can use provided
`examples/authorizer.rb` Sinatra app. Set your redirect URL to
`http://localhost:4567/' and run the app:

    $ cd examples/
    $ ruby authorizer.rb

Browse to http://localhost:4567/, follow the instructions, and after
successfully authorizing you will see serialized authentication data
as a YAML snippet.

To actually call the API, use `.request`, `.get`, `.post`, `.put`, and
`.delete` methods of the WordPressCom instance, or use the `token`
attribute to get to OAuth2 token itself:

    wpc.post('posts/new', :body => {
      :title => "Hello, World!",
      :content => "Lorem ipsum dolor sit amet",
      :tags => 'foo,bar,xyzzy'})
      
The request methods are automatically prefixed with
`/rest/v1/sites/$site_id/`. To get rid of the `/sites/$site_id/` part,
provide `:root_path => true` keyword parameter.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
