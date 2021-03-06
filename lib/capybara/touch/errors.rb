module Capybara::Touch
  class InvalidResponseError < StandardError
  end

  class NoResponseError < StandardError
  end

  class NodeNotAttachedError < Capybara::ElementNotFound
  end

  class ClickFailed < StandardError
  end

  class TimeoutError < Timeout::Error
  end

  class JsonError
    def initialize(response)
      error = JSON.parse response

      @class_name = error['class']
      @message = error['message']
    end

    def exception
      error_class.new @message
    end

    private

    def error_class
      Capybara::Touch.const_get @class_name
    end
  end
end
