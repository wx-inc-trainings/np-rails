module Api
  module V1
    class OpenLibraryController < ApplicationController
      def show
        book_info = OpenLibraryService.new(params[:isbn]).book_info
        render json: book_info[:response], status: book_info[:status]
      end
    end
  end
end
