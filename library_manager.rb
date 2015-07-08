require 'active_support/all'
require 'pry'

require_relative 'author.rb'
require_relative 'book.rb'
require_relative 'published_book.rb'
require_relative 'reader.rb'
require_relative 'reader_with_book.rb'

class LibraryManager

  attr_accessor :readers, :books, :readers_with_books

  def initialize readers = [], books = [], readers_with_books = []
    @readers = readers
    @books = books
    @readers_with_books = readers_with_books    
  end

  def new_book author, title, price, pages_quantity, published_at

  end

  def new_reader  name, reading_speed

  end

  def give_book_to_reader reader_name, book_title

  end

  def read_the_book reader_name, duration

  end

  def reader_notification name
    
  end

  def librarian_notification

  end

  def statistics_notification

  end

  private

    def reader_notification_params
  
    end
  
    def librarian_notification_params
  
    end
  
    def statistics_notification_params
  
    end

end
