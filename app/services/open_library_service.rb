require 'httparty'
require 'json'

class OpenLibraryService
  include Concurrent::Async
  def initialize(isbn, base_uri = ENV['BASE_URI'])
    @isbn = isbn
    @base_uri = base_uri
  end

  def book
    response = HTTParty.get("#{@base_uri}/books?bibkeys=ISBN:#{@isbn}&format=json&jscmd=data")
    if response.code == 200
      hash = JSON.parse(response.body).with_indifferent_access
      build_response(hash)
    else
      {
        code: response.code,
        message: response.message
      }
    end
  end

  private

  def build_response(data)
    book_data = data[type_isbn]
    {
      ISBN: @isbn,
      title: book_data[:title],
      subtitle: book_data[:subtitle],
      number_of_pages: book_data[:number_of_pages],
      authors: book_data[:authors]
    }
  end

  def type_isbn
    "ISBN:#{@isbn}".to_s
  end
end
