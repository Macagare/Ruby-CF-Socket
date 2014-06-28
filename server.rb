require 'socket'

def incommingMessage(client)
    data = ""
    incomming_length = 56
    while( tmp = client.recv(incomming_length) )
        data += tmp
        break if tmp.length < incomming_length
    end
    return data
end

def init()
    server = TCPServer.open(2000)
    loop {
        client = server.accept
        puts incommingMessage(client)
        client.puts "Hi from ruby, cya!"
        client.close
    }
end

init()