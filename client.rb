require 'socket'        # Sockets are in standard library
#require 'subprocess'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

f = open('myfile.rb', 'w') 

while line = s.gets     # Read lines from the socket
   puts line.chop       # And print with platform line terminator
   #File.write('./testFile.rb', line)
   f.puts(line)
end
sys = system ('start ruby "myfile.rb"', out: $stdout, err: :out)
#sys = %x{start ruby "myfile.rb}
puts(sys)
puts(out)
s.close                 # Close the socket when done
