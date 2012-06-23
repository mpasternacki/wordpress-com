# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wordpress-com/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Maciej Pasternacki"]
  gem.email         = ["maciej@pasternacki.net"]
  gem.description   = 'Ruby client for WordPress.com REST API'
  gem.summary       = 'WordPress.com REST API client'
  gem.homepage      = "https://github.com/mpasternacki/wordpress-com/"
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wordpress-com"
  gem.require_paths = ["lib"]
  gem.version       = WordpressCom::VERSION

  gem.add_dependency "json"
  gem.add_dependency "oauth2"

  gem.add_development_dependency "pry"
end
