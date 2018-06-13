require 'socket'                # Get sockets from stdlib
require 'json'

server = TCPServer.open(2000)   # Socket to listen on port 2000
content = File.read('program.rb')

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

loop {                          # Servers run forever
   Thread.start(server.accept) do |client|
   client.puts(content)
   puts(client.gets)
   client.close                 # Disconnect from the client
   end
}
