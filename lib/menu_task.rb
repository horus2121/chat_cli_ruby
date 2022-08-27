class MenuTask

    def menu
        puts "\u{1f4d6}  1.Menu"
        puts "\u{1f4ad}  2.Get a fun fact"
        puts "\u{1f465}  3.Share a fun fact"
        puts "\u{1f978}   4.Random number guessing game"
        puts "\u{1f6b6}  5.Quit room"
        puts "> Please enter '#' + 'number' to invoke a task!"
    end

    def get_fact(client, input)
        fact = "\u{1f4ad}  " + FetchAPI.get_fact

        case input
            when "#2"
                puts fact
            when "#3"
                puts fact
                client.puts fact
        end

    end

    def guess_number
        puts "\u{1f449}  Enter the start of range:"
        input_start = is_integer?(STDIN.gets.chomp) 
        start_of_range = input_start.to_i

        puts "\u{1f449}  Enter the end of range:"
        input_end = is_integer?(STDIN.gets.chomp)
        end_of_range = input_end.to_i 

        if end_of_range <= start_of_range 
            puts "\u{1f47e}  Invalid range!"
        else
            rand_num = rand(start_of_range...end_of_range).to_i
            puts "\u{1f449}  Please guess the number from #{start_of_range} to #{end_of_range} (#{end_of_range} is exclusive!) You have 7 chances!"

            7.times do

                input_guess = STDIN.gets.chomp

                if input_guess.downcase == ("quit" || "q")
                    puts "\u{1f449}  Quit the game."
                    return
                else
                    input_guess = is_integer?(input_guess)
                    guess = input_guess.to_i
                    case 
                        when guess == rand_num
                            puts "\u{1f389}  You win!"
                            return
                        when guess > rand_num
                            puts "\u{1f4a1}  Too high!"
                        when guess < rand_num
                            puts "\u{1f4a1}  Too low!"
                    end

                end

            end

            puts "\u{1f47b}  You lost!"

        end

    end

    def set_quick_replies
    end

    private

    def is_integer?(input)

        if input =~ /\s*\d+\s*/
            input.to_i
        else
            puts "\u{1f47e}  Plase enter a valid number!"
            input = STDIN.gets.chomp
            is_integer?(input)
        end

    end

end