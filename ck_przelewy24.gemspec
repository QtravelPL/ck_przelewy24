$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ck_przelewy24/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ck_przelewy24"
  s.version     = CkPrzelewy24::VERSION
  s.authors     = ["Cyberkom"]
  s.email       = ["office@cyberkom.pl"]
  s.summary     = "Gem operating Przelewy24 payments"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.test_files = Dir["spec/**/*"]

  s.required_ruby_version = ">= 3.1.7"

  s.add_dependency "rails", ["> 7.0", "< 7.1"]
  s.add_dependency "httparty"
  s.add_dependency "responders"

  s.add_development_dependency "pg"
  s.add_development_dependency "puma"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "webmock"
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency "shoulda-matchers"
end
