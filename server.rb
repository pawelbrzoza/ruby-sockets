require 'socket'                 # Get sockets from stdlib
require 'json'


server = TCPServer.open(2000)    # Socket to listen on port 2000


content = File.read('program.rb')

loop {                           # Servers run forever
   Thread.start(server.accept) do |client|
   #client.puts(Time.now.ctime)   # Send the time to the client
   #client.puts "Closing the connection. Bye!"
   client.puts(content)
   client.close                  # Disconnect from the client
   end
}