class Api::V1::OpenLibraryController < ApplicationController
  def show
    open_library_service = OpenLibraryService.new(params[:id])
    book = open_library_service.book
    render json: book
  end
end
