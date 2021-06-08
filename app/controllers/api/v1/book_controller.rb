require_relative '../../serializer/book_serializer'

module Api
  module V1
    class BookController < ApplicationController
      before_action :authenticate_user!
      def index
        @books = Book.all
        render_paginated json: Panko::Response.new(
          success: true,
          total_books: @books.count,
          books: Panko::ArraySerializer.new(@books, each_serializer: BookSerializer)
        )
      end

      def show
        @finded = find_book
        render_paginated json: Panko::Response.new(
          success: true,
          books: Panko::ArraySerializer.new(@finded, each_serializer: BookSerializer)
        )
      end

      private

      def find_book
        @book = Book.find(params[:id])
      end
    end
  end
end
