require_relative 'library'

class Main
  def initialize
  end

  puts "Welcome to the Library Catalog!"

  def show_menu()
    puts "\n********** MAIN MENU **********"
    puts 
    puts "1. Add book"
    puts "2. Update book"
    puts "3. Delete book"
    puts "4. Search by title"
    puts "5. Search by author"
    puts "6. Search by genre"
    puts "7. Display catalog"
    puts "8. Export catalog"
    puts "9. Exit"
    puts 
  end
  
  def main()
    library = Library.new
    search = Search.new
    count =0
    
    loop do
      show_menu()
      choice = get_choice(count)
      case choice
      when 1
        library.add_book()
      when 2
        library.update_book()
      when 3
        library.delete_book()
      when 4
        search.search_by_title(library.catalog)
      when 5
        search.search_by_author(library.catalog)
      when 6
        search.search_by_genre(library.catalog)
      when 7
        library.display_catalog()
      when 8
        library.export_catalog()
      when 9
        puts "Goodbye! Have a great day :)"
        break
      else
        puts "Invalid choice. You can try again."
      end
      count =0
    end
  end
  
  def get_choice(count)
    loop do
      print "\nPlease select your choice: "
      choice = gets.chomp.to_i
      if (1..9).include?(choice)
        return choice
      else
        count +=1
        if count >=3
          puts "\nYou have reached your maximum limit."
          puts "Thank you!"
          exit
        end
        puts "\nInvalid choice. Please try again."
      end
    end
  end

end

Main.new.main()