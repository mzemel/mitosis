require 'spec_helper'

describe "Redis" do

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

  it "allows simple read/write" do
    message = "message"
    queue = "test"

    @client.set(queue, message)

    expect(@client.get(queue)).to eq(message)
  end

  it "can use queues" do
    queue = Mitosis::Redis.error_queue
    queue_name = "#{File.basename(Dir.getwd)}:error"
    message = "message"

    queue.push(message)
    expect(@client.llen(queue_name)).to eq(1)
  end
end