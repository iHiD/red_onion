# -*- encoding: utf-8 -*-
require File.expand_path('../lib/red_onion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Walker"]
  gem.email         = ["jez.walker@gmail.com"]
  gem.description   = %q{Automatic onion caching for Rails}
  gem.summary       = %q{Automatic onion caching for Rails}
  gem.homepage      = "http://www.ihid.co.uk/projects/red_onion"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "red_onion"
  gem.require_paths = ["lib"]
  gem.version       = RedOnion::VERSION
end
