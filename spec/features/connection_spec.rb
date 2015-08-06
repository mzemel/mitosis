require 'spec_helper'

describe "Database Connection" do

  before :all do
    system("bin/start_test_redis &")
    sleep 5
    @client ||= Mitosis::Redis.client
  end

  after :all do
    system("bin/stop_test_redis")
  end

  trap "SIGINT" do
    system("bin/stop_test_redis")
    exit 0
  end

  it "starts, stops, writes to, and can read from Redis" do
    message = "message"
    queue = "test"

    @client.set(queue, message)

    expect(@client.get(queue)).to eq(message)
  end
end