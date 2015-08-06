require 'redis'
require "redis-queue"

ENV["MITOSIS_REDIS_HOST"] ||= "127.0.0.1"

module Mitosis
  module Redis
    def self.client
      @client ||= if ENV["MITOSIS_REDIS_PASSWORD"]
          ::Redis.new(url: redis_url, password: ENV["MITOSIS_REDIS_PASSWORD"])
        else
          ::Redis.new(url: redis_url)
        end
    end

    def self.redis_url
      port = ENV['RACK_ENV'] == 'test' ? ":6379/1" : ":6379/0"
      "redis://" + ENV["MITOSIS_REDIS_HOST"] + port
    end

    def self.error_queue
      @error_queue ||= ::Redis::Queue.new("#{File.basename(Dir.getwd)}:error", "what_does_this_do", :redis => @client)
    end

    def self.audit_queue
      @audit_queue ||= ::Redis::Queue.new("#{File.basename(Dir.getwd)}:audit", "what_does_this_do", :redis => @client)
    end
  end
end