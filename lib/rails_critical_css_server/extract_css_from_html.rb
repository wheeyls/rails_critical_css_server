module RailsCriticalCssServer
  class ExtractCssFromHtml
    extend Callable
    attr_reader :html

    def initialize(html)
      @html = html
    end

    def call
      regex = /<link.+href=\"([^"]+\.css[^"]*)\"/

      html.gsub(/<link/, "\n<link").scan(regex).flatten
    end
  end
end
