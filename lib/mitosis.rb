require "mitosis/version"
require "mitosis/disque"
require 'json'

module Mitosis
  class << self

    def client
      @client ||= Mitosis::Disque.client
    end

    def log(exception, queue)
      queue ||= File.basename(Dir.getwd)
      message = convert_to_json(exception)
      client.push(queue, message, 1000)
      STDOUT.puts message
      raise exception
    end

    def convert_to_json(exception)
      {
        "class" => exception.class.name,
        "message" => exception.message,
        "stacktrace" => exception.backtrace.join(", ")
      }.to_json
    end
  end
end
