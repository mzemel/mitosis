require "mitosis/version"
require "mitosis/redis"
require 'json'

module Mitosis
  class << self

    def client
      @client ||= Mitosis::Redis.client
    end

    def log(exception, queue = nil)
      queue ||= File.basename(Dir.getwd)
      message = convert_to_json(exception)
      puts queue
      client.push(queue, message, 1000)
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
