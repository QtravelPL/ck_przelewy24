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

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "httparty"
  s.add_dependency "responders"
  s.add_dependency "apipie-rails"

  s.add_development_dependency "pg"
  s.add_development_dependency "puma"

  s.add_development_dependency "rspec-rails", "~> 3.5.2"
  s.add_development_dependency "webmock", ">= 2.0"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "shoulda-matchers"
end
