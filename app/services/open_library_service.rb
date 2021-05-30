class OpenLibraryService
  require 'httparty'
  URL = Rails.application.credentials[:base_uri]
  def initialize(isbn)
    @isbn = isbn
  end

  def book_info
    response = find_book
    return build_bad_response if response.parsed_response.blank?

    hash = JSON.parse(response.body).with_indifferent_access
    return { response: build_response(hash), status: response.code } if response.code == 200
  end

  private

  def find_book
    options = {
      bibkeys: @isbn,
      format: 'json',
      jscmd: 'data'
    }
    HTTParty.get(URL, query: options )
  end

  def build_response(data)
    book_data = data[@isbn]
    {
      ISBN: @isbn,
      title: book_data[:title],
      subtitle: book_data[:subtitle],
      number_of_pages: book_data[:number_of_pages],
      authors: book_data[:authors]
    }
  end

  def build_bad_response
    { status: 404, response: { message: 'Book not found' } }
  end

  def type_isbn
    "ISBN:#{@isbn}".to_s
  end
end
