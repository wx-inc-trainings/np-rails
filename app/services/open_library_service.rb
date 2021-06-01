class OpenLibraryService
  require 'httparty'
  BASE_URI = Rails.application.credentials[Rails.env.to_sym][:open_library_api][:base_uri]
  def initialize(isbn)
    @isbn = isbn
  end

  def book_info
    response = find_book
    return build_bad_response if response.parsed_response.blank?

    hash = JSON.parse(response.body).with_indifferent_access
    return build_correct_response(build_book_info(hash), response) if response.code == 200
  end

  private

  def find_book
    options = {
      bibkeys: @isbn,
      format: 'json',
      jscmd: 'data'
    }
    HTTParty.get(BASE_URI, query: options)
  end

  def build_book_info(data)
    book_data = data[@isbn]
    {
      ISBN: @isbn,
      title: book_data[:title],
      subtitle: book_data[:subtitle],
      number_of_pages: book_data[:number_of_pages],
      authors: book_data[:authors]
    }
  end

  def build_correct_response(hash, response)
    { response: hash, status: response.code }
  end

  def build_bad_response
    { status: 404, response: { error: 'Book not found' } }
  end
end
