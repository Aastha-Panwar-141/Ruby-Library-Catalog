module Validation
    def valid_year(message, allow_blank: false)
        count = 0
        loop do
            print message
            user_input = gets.chomp.strip

            if user_input.empty? && allow_blank
                count += 1
                if count == 3
                    puts "\nExceding limit. returing to main menu: "
                    return nil
                end
                puts "Invalid input. Year can't be blank."
                next
            end
            year = user_input.to_i
            current_year = Time.now.year
            if year.between?(1800, current_year)
                return year
            else
                count += 1
                if count == 3 
                    puts "\nExceding limit. returing to main menu: "
                    return nil
                end
                puts "Invalid year. Enter year between 1800 and #{current_year}"
            end

        end
    end

    def valid_input(message)
        count = 0
        loop do
            print message
            user_input = gets.chomp.strip

            if user_input.empty?
                count += 1
                if count == 3
                    puts "\nExceding limit. returing to main menu: "
                    return
                end
                puts "Invalid input. Try again."
            else
                count = 0
                return user_input
            end
        end
    end
end