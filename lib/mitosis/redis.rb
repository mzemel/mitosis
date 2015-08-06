require 'redis'

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
  end
end