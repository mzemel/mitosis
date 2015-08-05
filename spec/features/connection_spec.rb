require 'spec_helper'

describe "Database Connection" do

  before :all do
    @disque_pid = Process.fork do
      exec("bin/start_test_disque")
      sleep 5 # sleep while disque starts up
    end
    @client ||= Mitosis::Disque.client
  end

  after :all do
    Process.kill("KILL", @disque_pid)
  end

  trap "SIGINT" do
    Process.kill("KILL", @disque_pid)
    exit 0
  end

  it "starts, stops, writes to, and can read from Disque" do
    message = "message"
    queue = "test"
    return_message = ""

    @client.push(queue, message, 100)
    @client.fetch(from: "test") do |m|
      return_message = m
    end

    expect(message).to eq(return_message)
  end
end