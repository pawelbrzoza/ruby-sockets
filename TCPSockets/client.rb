#!/usr/bin/ruby

require 'socket'        # Sockets are in standard library
require 'shell'

RUBY = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])

hostname = 'localhost'
port = 2000
syntax = ""

s = TCPSocket.open(hostname, port)
s.puts("Connection OK")
f = open('myfile.rb', 'w') 

while line = s.gets     # Read lines from the socket
   puts line.chop       # And print with platform line terminator
   f.puts(line)
end

Shell.def_system_command :ruby, RUBY
shell = Shell.new
process = shell.transact do
	ruby('./myfile.rb')
end

output = process.to_s
output.split("\n").each do |line|
  	puts "[parent] output: #{line}"
	if "#{line}" == "[child] works"
		syntax = "Syntax ok"

	elsif "#{line}" == "[child] error"
		syntax = "Syntax error"
	end
end

s.close

s = TCPSocket.open(hostname, port)
s.puts(syntax)
s.close

