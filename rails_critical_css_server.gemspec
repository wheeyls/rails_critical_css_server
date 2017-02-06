$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_critical_css_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_critical_css_server"
  s.version     = RailsCriticalCssServer::VERSION
  s.authors     = ["Michael Wheeler"]
  s.email       = ["mwheeler@g2crowd.com"]
  s.homepage    = "https://github.com/wheeyls/rails_critical_css_server"
  s.summary     = "Prioritize above-the-fold CSS in a Rails application"
  s.description = "Client for critical_css_server. This server generates the critical path CSS for you. It is designed to sit alongside your production app, and prepare the critical CSS asynchronously."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.0"
  s.add_dependency "httparty", "~> 0.13.3"

  s.add_development_dependency('rspec')
end
