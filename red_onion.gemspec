$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "red_onion/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "red_onion"
  s.version     = RedOnion::VERSION
  s.authors       = ["Jeremy Walker"]
  s.email         = ["jez.walker@gmail.com"]
  s.description   = %q{Automatic onion caching for Rails}
  s.summary       = %q{Automatic onion caching for Rails}
  s.homepage      = "http://www.ihid.co.uk/projects/red_onion"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end