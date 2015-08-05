require 'disque'

ENV["DISQUE_HOST"] ||= "127.0.0.1"
ENV["DISQUE_PORT"] ||= "7711"
ENV["DISQUE_LOCATION"] ||= ENV["DISQUE_HOST"] + ":" + ENV["DISQUE_PORT"]

module Mitosis
  module Disque
    def self.client
      @client ||= ::Disque.new(ENV["DISQUE_LOCATION"])
    end
  end
end