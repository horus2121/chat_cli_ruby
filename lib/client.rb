require_relative '../config/env'
require_relative './fun_fact.rb'

class Client < TCPSocket
end

class HandleThread

    def self.local_typing(client)

        loop do
            # print "(me)>"
            # input = STDIN.noecho(&:gets).chomp
            input = STDIN.gets.chomp
            case input
            when "#1", "menu", "MENU"
                self.menu
            when "#2", "#3"
                self.get_fact(client, input)
            when "#4"
                self.guess_number
            when "#5", "quit"
                exit
            else
                client.puts input
            end
        end

    end

    def self.receive_from_server(client)

        while line = client.gets do
            puts line
        end

    end

    def self.menu
        puts "1.Menu"
        puts "2.Get a fun fact"
        puts "3.Share a fun fact"
        puts "4.Random number guessing game"
        puts "5.Quit room"
        puts "Please enter '#' + 'number' to invoke a task!"
    end

    def self.get_fact(client, input)
        fact = FetchAPI.get_fact

        case input
            when "#2"
                puts fact
            when "#3"
                puts fact
                client.puts fact
        end

    end

    def self.guess_number
        puts "Enter the start of range:"
        input_start = self.is_integer?(STDIN.gets.chomp) 
        start_of_range = input_start.to_i

        puts "Enter the end of range:"
        input_end = self.is_integer?(STDIN.gets.chomp)
        end_of_range = input_end.to_i 

        if end_of_range <= start_of_range 
            puts "Invalid range!"
        else
            rand_num = rand(start_of_range..end_of_range).to_i
            puts "Please guess the number from #{start_of_range} to #{end_of_range} (#{end_of_range} is exclusive!) You have 7 chances!"

            7.times do

                input_guess = STDIN.gets.chomp

                if input_guess.downcase == ("quit" || "q")
                    puts "Quit the game."
                else
                    input_guess = self.is_integer?(input_guess)
                    guess = input_guess.to_i
                    case 
                        when guess == rand_num
                            puts "You win!"
                            return
                        when guess > rand_num
                            puts "Too high!"
                        when guess < rand_num
                            puts "Too low!"
                    end

                end

            end

            puts "You lost!"

        end

    end

    def self.is_integer?(input)

        if input =~ /\s*\d+\s*/
            input.to_i
        else
            puts "Plase enter a valid number!"
            input = STDIN.gets.chomp
            self.is_integer?(input)
        end

    end

    # Cannot make it class private method??
    # class << self
    #     private :get_fact
    # end

end