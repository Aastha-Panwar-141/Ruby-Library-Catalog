class Book
  attr_accessor :b_title, :b_author, :b_genre, :b_year
  
  def initialize(b_title, b_author, b_genre, b_year)
    @b_title = b_title
    @b_author = b_author
    @b_genre = b_genre
    @b_year = b_year
  end
end