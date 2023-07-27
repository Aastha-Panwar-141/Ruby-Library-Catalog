# require_relative 'book'
# require_relative 'validation'
require_relative 'library'

class Search
    def search_by_title(catalog)   #catalog = array of Book collection in library
        search_and_show_result('b_title', catalog)
    end
    def search_by_author(catalog)
        search_and_show_result('b_author', catalog)
    end
    def search_by_genre(catalog)
        search_and_show_result('b_genre', catalog)
    end
    def search_and_show_result(search_for, catalog)
        if catalog.empty?  #checks for empty catalog
            puts "\nNo book is available to search. "
        else
            print "\nEnter the #{search_for} to search for: "
            input = gets.chomp  #take user input to search for 
            books = catalog.find_all { |book| book.send(search_for).downcase.include?(input) }
            display_search_result(books)  #books = array of matching books
        end
    end
    def display_search_result(books)
        if books.empty?  
            puts "\nNo book found for your search."
        else
            puts "\nMatched Result: "
            books.each { |book| puts "#{book.b_title} by #{book.b_author}" }
        end
    end
end