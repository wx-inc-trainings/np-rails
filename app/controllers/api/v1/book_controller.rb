module Api
  module V1
    class BookController < ApiController
      def index
        books = Book::Reducer.apply(params)
        render_paginated books, each_serializer: Api::V1::Serializer::BookSerializer
      end

      def show
        if exist_book
          render json: Api::V1::Serializer::BookSerializer.new.serialize_to_json(find_book)
        else
          render json: book_not_found, status: 404
        end
      end

      private

      def exist_book
        Book.friendly.exists?(params[:id])
      end

      def find_book
        @find_book ||= Book.friendly.find(params[:id])
      end

      def book_not_found
        { error: 'Book not found' }
      end
    end
  end
end
