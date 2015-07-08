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
    # binding.pry
    @readers = (readers_with_books.map { |r_w_b| r_w_b.reader} + readers).uniq
    @books = (readers_with_books.map { |r_w_b| r_w_b.amazing_book} + books).uniq
    @readers_with_books = readers_with_books
    @statistics = {}
    populate_statistics!
    # binding.pry
  end

  def new_book author, title, price, pages_quantity, published_at
    books.push(PublishedBook.new(author, title, price, pages_quantity, published_at))
    populate_statistics!
  end

  def new_reader reader_name, reading_speed
    readers.push(Reader.new(reader_name, reading_speed))
    populate_statistics!
  end

  def give_book_to_reader reader_name, book_title

  end

  def read_the_book reader_name, duration

  end

  def reader_notification reader_name
    p = reader_notification_params(reader_name)
    return <<-TEXT
Dear #{p[:reader_name]}!

You should return a book "#{p[:book_title]}" authored by #{p[:author_name]} in #{p[:hours_until_return]} hours.
Otherwise you will be charged $#{p[:penalty_per_hour]} per hour.
By the way, you are on #{p[:current_page]} page now and you need #{p[:hours_to_finish]} hours to finish reading "#{p[:book_title]}"
TEXT
  end

  def librarian_notification
    p = librarian_notification_params
    return <<-TEXT
Hello,

There are #{p[:books_count]} published books in the library.
There are #{p[:readers_count]} readers and #{p[:readers_w_b_count]} of them are reading the books.

#{p[:readers_w_b_info]}
TEXT
  end

  def statistics_notification
    p = statistics_notification_params
    return <<-TEXT
Hello,

The library has: #{p[:books]} books, #{p[:authors]} authors, #{p[:readers]} readers
TEXT
  end
# The most popular author is #{p[:author]}: #{p[:author_p]} pages has been read in #{p[:author_b]} books by #{p[:author_r]} readers.
# The most productive reader is #{p[:reader]}: he had read #{p[:reader_p]} pages in #{p[:reader_b]} books authored by #{p[:reader_a]} authors.
# The most popular book is "#{p[:book]}" authored by #{p[:book_a]}: it had been read for #{p[:book_h]} hours by #{p[:book_r]} readers.

  private

    def reader_notification_params reader_name
      r = @readers_with_books.find { |reader_w_b| reader_w_b.reader.name == reader_name }
      p = {}
      p[:reader_name] = r.reader.name
      p[:book_title] = r.amazing_book.title
      p[:author_name] = r.amazing_book.author.name
      p[:hours_until_return] = format('%.2f', r.hours_until_return.round(2))
      p[:penalty_per_hour] = format('%.2f', r.amazing_book.penalty_per_hour.round(2))
      p[:current_page] = r.current_page
      p[:hours_to_finish] = format('%.2f', r.hours_to_finish.round(2))
      return p
    end

    def librarian_notification_params
      p = {}
      p[:books_count] = @books.size
      p[:readers_count] = @readers.size
      p[:readers_w_b_count] = @readers_with_books.size
      # p[:readers_w_b_info] = @readers_with_books.inject("") { |memo, reader_w_b| memo + reader_w_b.inspect + "\n" }
      p[:readers_w_b_info] = @readers_with_books.map do |reader_w_b| 
        "#{reader_w_b.reader.name} is reading \"#{reader_w_b.amazing_book.title}\"" + 
        " - should return on #{reader_w_b.return_date.strftime("%F")} at#{' ' + reader_w_b.return_date.strftime("%l%p").downcase.strip}" + 
        " - #{format('%.2f', reader_w_b.hours_to_finish.round(2))} hours of reading is needed to finish."
      end.join("\n")
      return p
    end
  
    def statistics_notification_params
      p = {}
      p[:books] = @books.size
      p[:authors] = @books.map { |b| b.author}.uniq.size
      p[:readers] = @readers.size
      # p_authors = {}
      # @readers_with_books.each do |reader_w_b|
      #   p_authors[reader_w_b.amazing_book.author.name] +=
      # end
      return p
    end

    def populate_statistics!

    end

end


