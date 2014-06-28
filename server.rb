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
        Thread.start(server.accept) do |client|
            msg = incommingMessage(client)
            sleep(Random.rand(5))
            client.puts msg
            client.close
        end     
    }
end

init()