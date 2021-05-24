class OpenLibraryController < ApplicationController
  def book
    open_library_service = OpenLibraryService.new
    book = open_library_service.book
    render json: book
  end
end
