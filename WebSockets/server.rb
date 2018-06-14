require 'eventmachine'
require 'websocket-eventmachine-server'

PORT = (ARGV.shift || 8080).to_i
EM::run do
  @channel = EM::Channel.new

  puts "start websocket server - port:#{PORT}"

  WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => PORT) do |ws|
    ws.onopen do
      sid = @channel.subscribe do |mes|
        ws.send mes
        
      end
      puts "<#{sid}> connect"
      
      ws.onmessage do |msg|
        puts "<#{sid}> #{msg}"
        sourcefile = "client#{sid}_source.rb"
        outputfile = "client#{sid}_output.txt"
        syntaxfile = "client#{sid}_syntax.txt"
        f = open(sourcefile, 'w') 
        f.puts(msg)
        f.close
        system("ruby-lint #{sourcefile} > #{syntaxfile}")
        syntax = File.read(syntaxfile)
        if syntax
            @channel.push syntax
        end

        # f1 = IO.readlines(sourcefile).map(&:chomp)
        # f2 = IO.readlines(outputfile).map(&:chomp)
        # File.open("diff.txt","w"){|f3| f3.write(
        #     (f1-f2).join("\n")
        # )}

        system("ruby #{sourcefile} > #{outputfile}")
        r = File.read(outputfile)
        @channel.push r
      end
      ws.onclose do
        puts "<#{sid}> disconnected"
        @channel.unsubscribe sid
        @channel.push "<#{sid}> disconnected"
        
      end
    end
  end

end