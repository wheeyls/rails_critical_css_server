require 'rails_critical_css_server/engine'
require 'rails_critical_css_server/callable'
require 'rails_critical_css_server/config'
require 'rails_critical_css_server/client'
require 'rails_critical_css_server/extract_css_from_html'
require 'rails_critical_css_server/rewrite'
require 'rails_critical_css_server/error_handler'

module RailsCriticalCssServer
  def self.config
    yield RailsCriticalCssServer::Config
  end
end
