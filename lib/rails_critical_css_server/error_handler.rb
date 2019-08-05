module RailsCriticalCssServer
  class ErrorHandler
    extend Callable
    attr_reader :error

    def initialize(error)
      @error = error
    end

    def call
      Rails.logger.error error
    end
  end
end
