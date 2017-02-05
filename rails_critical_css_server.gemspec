$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_critical_css_server/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_critical_css_server"
  s.version     = RailsCriticalCssServer::VERSION
  s.authors     = ["Michael Wheeler"]
  s.email       = ["mwheeler@g2crowd.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsCriticalCssServer."
  s.description = "TODO: Description of RailsCriticalCssServer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
