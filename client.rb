require 'rubygems'
require 'websocket-client-simple'

content = File.read('program.rb')

ws = WebSocket::Client::Simple.connect 'ws://localhost:8080'

ws.on :message do |msg|
  puts msg.data
end

ws.on :open do
# ws.send 'hello!!!'
ws.send content
end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
end

loop do
  ws.send STDIN.gets.strip
end


# require 'socket'        # Sockets are in standard library
# #require 'subprocess'

# hostname = 'localhost'
# port = 2000

# s = TCPSocket.open(hostname, port)

# f = open('myfile.rb', 'w') 

# while line = s.gets     # Read lines from the socket
#    puts line.chop       # And print with platform line terminator
#    #File.write('./testFile.rb', line)
#    f.puts(line)
# end
# #sys = system ('start ruby "myfile.rb"', out: $stdout, err: :out)
# #sys = %x{start ruby "myfile.rb}
# puts(sys)
# puts(out)
# s.close                 # Close the socket when done