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

  s.add_dependency "rails", [">= 6.1", "< 7.0"]
  s.add_dependency "httparty", "~> 0.23"
  s.add_dependency "responders", "~> 3.1"
  s.add_dependency "concurrent-ruby", "1.3.4"

  s.add_development_dependency "pg", "~> 1.5"
  s.add_development_dependency "puma", "~> 6.0"

  s.add_development_dependency "rspec-rails", "~> 6.0"
  s.add_development_dependency "webmock", "~> 3.18"
  s.add_development_dependency 'factory_bot_rails', "~> 6.4"
  s.add_development_dependency "shoulda-matchers", "~> 6.5"
end
