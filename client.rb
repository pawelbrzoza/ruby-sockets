#!/usr/bin/env ruby
require 'socket'        # Sockets are in standard library
require 'open3'
require 'pty'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

f = open('myfile.rb', 'w') 

while line = s.gets     # Read lines from the socket
   puts line.chop       # And print with platform line terminator
   #File.write('./testFile.rb', line)
   f.puts(line)
end

begin
  PTY.spawn( "ruby myfile.rb" ) do |stdout, stdin, pid|
    begin
      stdout.each { |line| print line }
    rescue Errno::EIO
    end
  end
rescue PTY::ChildExited
  puts "The child process exited!"
end

s.close                 # Close the socket when done