# require ARGV, OptParse, Thor
require_relative '../config/env' 


class Server < TCPServer

    def message_sysyem(clients, client)

        client_name = client.gets.chomp
        # client_avarta = "\u{1fkjj}"

        client.puts "\u{1f50a} Hello #{client_name}! Clients connected: #{clients.count}"

        self.announce_to_everyone clients, "\u{1f50a} #{client_name} joined!"

        while line = client.gets do
            incoming_data_from_client = line.chomp
            # self.announce_to_everyone clients, "#{client_name}: #{incoming_data_from_client}"
            # self.announce_to_self client, "(me)> #{incoming_data_from_client}"
            self.announce_to_others clients, client, "#{client_name}> #{incoming_data_from_client}" 
        end

        client.close
        clients.delete(client)
        self.announce_to_everyone clients, "\u{1f50a} #{client_name} left!"
    end

    def announce_to_everyone(clients, text)
        clients.each { |client| client.puts text }
    end

    def announce_to_self(client, text)
        client.puts text
    end

    def announce_to_others(clients, myself, text)
        clients.each { |client| if client != myself then client.puts text else end}
    end

end
