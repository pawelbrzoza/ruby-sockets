require 'rubygems'
require 'eventmachine'
require 'websocket-client-simple'

content = File.read('program.rb')

EM::run do

    ws = WebSocket::Client::Simple.connect 'ws://localhost:8080'
    
    ws.on :open do
        ws.send content
        end

    ws.on :message do |msg|
        puts msg.data
        EM::stop
    end

    ws.on :close do |e|
    p e
    exit 1
    end

    ws.on :error do |e|
    p e
    end
end
