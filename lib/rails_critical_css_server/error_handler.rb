module RailsCriticalCssServer
  class ErrorHandler
    extend Callable

    def call(error)
      Rails.logger.error error
    end
  end
end
