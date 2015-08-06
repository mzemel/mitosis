require "mitosis/version"
require "mitosis/redis"
require 'json'

module Mitosis
  class << self

    def error_queue
      @error_queue ||= Mitosis::Redis.error_queue
    end

    def audit_queue
      @audit_queue ||= Mitosis::Redis.audit_queue
    end

    def log(exception)
      queue = exception.is_a?(Exception) ? error_queue : audit_queue
      message = convert_to_json(exception)
      require 'pry'
      binding.pry

      queue.push(message)
    end

    def convert_to_json(exception)
      {
        "class" => exception.class.name,
        "message" => exception.message,
        "stacktrace" => exception.backtrace.join(", ")
      }.to_json # To do: make these keys configurable and exposable for types incl. Audits, Errors, etc.
    end
  end
end
