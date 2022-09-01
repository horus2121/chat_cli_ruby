# require ARGV, OptParse, Thor
require_relative '../config/env' 


class Server < TCPServer

    @@client_names = []

    def message_sysyem(clients, client)

        user_prefix = set_username client, @@client_names

        client.puts "\u{1f50a}  Hello #{user_prefix}! Clients connected: #{clients.count}"

        announce_to_others clients, client, "\u{1f50a}  #{user_prefix} joined!"

        while line = client.gets do
            incoming_data_from_client = line.chomp
            # self.announce_to_everyone clients, "#{user_prefix}: #{incoming_data_from_client}"
            # self.announce_to_self client, "(me)> #{incoming_data_from_client}"
            announce_to_others clients, client, "#{user_prefix}> #{incoming_data_from_client}" 
        end

        client.close
        clients.delete(client)
        announce_to_everyone clients, "\u{1f50a}  #{user_prefix} left!"
    end

    private

    def set_username(client, client_names)
        client_name = client.gets.chomp

        client_names.each do |name| 

            if name == client_name  
                announce_to_self client, "This name already exists!" 
                return set_username client, @@client_names
            else 
            end

        end

        # client_avarta = "\u{1fkjj}"
        @@client_names << client_name
        return client_name

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
