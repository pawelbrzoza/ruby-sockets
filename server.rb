require 'eventmachine'
require 'websocket-eventmachine-server'

PORT = (ARGV.shift || 8080).to_i
$f = open('myfile2.rb', 'w')
EM::run do
  @channel = EM::Channel.new

  puts "start websocket server - port:#{PORT}"

  WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => PORT) do |ws|
    ws.onopen do
      sid = @channel.subscribe do |mes|
        ws.send mes
        $f = open('myfile2.rb', 'w')
      end
      puts "<#{sid}> connect"

      @channel.push "hello new client <#{sid}>"

      ws.onmessage do |msg|
        puts "<#{sid}> #{msg}"
        if $f 
            $f.puts(msg)
            $f.close
            system("ruby myfile2.rb > log.txt")
            r = File.read('log.txt')
            @channel.push r
        end
        
        # @channel.push "<#{sid}> #{msg}"
      end
      
      ws.onclose do
        puts "<#{sid}> disconnected"
        @channel.unsubscribe sid
        @channel.push "<#{sid}> disconnected"
        
      end
    end
  end

end
  
# end

# require 'socket'                 # Get sockets from stdlib


# server = TCPServer.open(2000)    # Socket to listen on port 2000





# content = File.read('program.rb')

# loop {                           # Servers run forever
#    Thread.start(server.accept) do |client|
#    #client.puts(Time.now.ctime)   # Send the time to the client
#    #client.puts "Closing the connection. Bye!"
#    client.puts(content)
#    client.close                  # Disconnect from the client
#    end
# }