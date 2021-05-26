module Api
  module V1
    class OpenLibraryController < ApplicationController
      def show
        book = OpenLibraryService.new(params[:isbn]).book_info
        render json: book
      end
    end
  end
end
