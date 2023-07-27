require_relative 'book'
require_relative 'validation'
require 'csv'
require_relative 'search'

class Library
  attr_accessor :catalog
  include Validation
  def initialize
    @catalog = []
  end
  def add_book()
    puts "\nYou are Adding a Book"

    b_title = valid_input("\nEnter the title: ")
    return if b_title.nil?

    b_author = valid_input("\nEnter the author: ")
    return if b_author.nil?

    return if existing_book(b_title, b_author)

    b_genre = valid_input("\nEnter the genre: ")
    return if b_genre.nil?

    b_year = valid_year("\nEnter the year published: ")
    return if b_year.nil?

    book = Book.new(b_title, b_author, b_genre, b_year)
    @catalog << book
    puts "\nBook added successfully!"
  end

  def update_book()
    if @catalog.empty?
      puts "\nNo book is available to update. "
    else
      title = valid_input("\nEnter the book title to update: ")
      return if title.nil?

      book = find_book_by_title(title)
      if book
        puts "\nMatched result: "
        puts "#{book.b_title} by #{book.b_author}"

        update_data(book)
        puts "\nBook updated successfully."
      else
        puts "\nBook with title '#{title}' not found in catalog."
      end 
    end
  end
  
  def update_data(book_to_update)
    values = ['b_title', 'b_author', 'b_genre', 'b_year']
    values.each do |value|
      if value == 'b_year'
        updated_value = valid_year("Enter the updated year (Don't leave blank): ", allow_blank: true)
      else
        print "Enter the updated #{value} or leave blank for no change: "
        updated_value = gets.chomp.strip
      end
      if updated_value != ''
        book_to_update.b_title = updated_value if value == 'b_title'
        book_to_update.b_author = updated_value if value == 'b_author'
        book_to_update.b_genre = updated_value if value == 'b_genre'
        book_to_update.b_year = updated_value.to_i if value == 'b_year'
      end
    end
  end

  def delete_book()
    if @catalog.empty?
      puts "\nNo book is available to delete. "
    else
      puts "\nYou are Deleting a Book! Here is available book: "
      display_catalog()
      puts 
      b_title = valid_input("\nEnter the book title to delete: ")
      return if b_title.nil?

      book = find_book_by_title(b_title)

      if book
          @catalog.delete(book)
          puts "Book deleted successfully!"
      else
          puts "\nNo Book found for '#{b_title}'."
      end
    end
  end
  def display_catalog()
    if @catalog.empty?
      puts "\nNo book is available. "
    else
      puts "\nBooks Catalog:"
      puts 
      puts "Id\t\tTitle\t\tAuthor\t\tGenre\t\tYear Published"
      puts "====================================================================="
      @catalog.each_with_index do |book, index|
        puts "#{index+1}\t\t#{book.b_title}\t\t#{book.b_author}\t\t#{book.b_genre}\t\t#{book.b_year}"
      end
    end
  end

  def export_catalog()
    if @catalog.empty?
      puts "\nNo book is available in catalog.\nAdd book first to export."
    else
      CSV.open('catalog.csv', 'w') do |csv|  # w= overwrite on previous data, to append we can use 'a'
        csv << ['Title', 'Author', 'Genre', 'Year Published']  #header row
        @catalog.each do |book|
          csv << [book.b_title, book.b_author, book.b_genre, book.b_year]
        end
      end
=begin
      File.open('catalog.txt', 'w+') do |file|
        file.puts "Title\tAuthor\tGenre\tYear Published"
        @catalog.each do |book|
          file.puts "#{book.b_title}\t#{book.b_author}\t#{book.b_genre}\t#{book.b_year}"
        end 
      end
=end
      puts "\nCatalog exported successfully!"
    end
  end

  def existing_book(b_title, b_author)
    book_exist = @catalog.any? {|book| book.b_title.downcase == b_title.downcase && book.b_author.downcase == b_author.downcase}
    if book_exist
      puts "\nBook already exists with same author."
      return true
    end
    false
  end
  def find_book_by_title(b_title)
    @catalog.find { |book| book.b_title.downcase == b_title.downcase }
  end
end