#!/usr/bin/ruby

require 'socket'        # Sockets are in standard library
require 'shell'

RUBY = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])

hostname = 'localhost'
port = 2000
syntax = ""

#CHECKING CONNECTION
s = TCPSocket.open(hostname, port)
s.puts("Connection OK")
f = open('myfile.rb', 'w') 

#READING FILE
while line = s.gets     # Read lines from the socket
   puts line.chop       # And print with platform line terminator
   f.puts(line)
end
s.close

#IMPORTANT!
Shell.def_system_command :ruby, RUBY
shell = Shell.new
process = shell.transact do
	ruby('./myfile.rb')
end

syntax = system('ruby -c myfile.rb')
s = TCPSocket.open(hostname, port)

#SENDING INFO ABOUT SYNTAX
if syntax == true
	s.puts("Syntax OK")
	s.close
	#SENDING PROGRAM OUTPUT
	#output = process.to_s
	#output.split("\n").each do |line|
	require_relative "simpleNumbers.rb"
	SimpleNumber.new(2,3).start().each do |line|
  	puts "[parent] output: #{line}"
  	s = TCPSocket.open(hostname, port)
	s.puts("[parent] output: #{line}")
	s.close
end
else
	s.puts("Syntax NOT OK")
	s.close
end