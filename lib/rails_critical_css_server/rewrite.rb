module RailsCriticalCssServer
  class Rewrite
    extend Callable

    attr_reader :template, :manifest, :version, :block, :skip, :cache

    delegate :request, :params, to: :template

    def initialize(template, version: Config.version, skip: false, cache: true, &block)
      @template = template
      @version = version
      @skip = skip
      @block = block
      @cache = cache
    end

    def call
      return original_html unless should_run?
      return cached_value if cache && cached_value.present?
      return original_html unless content_ready?

      Rails.cache.write(self, rewritten_html) if cache
      rewritten_html
    end

    def cache_key
      [version, manifest, key].join(':')
    end

    private

    def manifest
      extracted_css_files.first
    end

    def cached_value
      return @cached_value if defined? @cached_value
      @cached_value = Rails.cache.read(self)
    end

    def content
      @content ||= client.read!
    end

    def content_ready?
      content.present? && content.ok?
    end

    def original_html
      return @original_html if defined? @original_html
      @original_html = template.capture { block.call }
    end

    def extracted_css_files
      @extracted_css_files ||= ExtractCssFromHtml.call(original_html)
    end

    def rewritten_html
      return @rewritten_html if defined? @rewritten_html

      @rewritten_html = template.capture do
        template.render 'rails_critical_css_server/css_load',
                        css_files: extracted_css_files,
                        critical_css: content,
                        original_html: original_html
      end
    end

    def should_run?
      !skip && !phantomjs_useragent? && Config.host.present?
    end

    def phantomjs_useragent?
      request.user_agent.present? && request.user_agent.match(/PhantomJS/)
    end

    def client
      @client ||= Client.new(key, request.original_url, extracted_css_files.first)
    end

    def key
      "#{params[:controller]}##{params[:action]}:#{version}"
    end

    def to_s
      self.class.to_s
    end
  end
end
