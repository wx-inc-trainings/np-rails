module Api
  module V1
    class BookController < ApiController
      BooksReducer = Rack::Reducer.new(
        Book.all,
        ->(author:) { where('lower(author) like ?', "%#{author.downcase}%") },
        ->(gender:) { where('lower(gender) like ?', "%#{gender.downcase}%") },
        ->(title:) { where('lower(title) like ?', "%#{title.downcase}%") }
      )

      def index
        books = BooksReducer.apply(params)
        render_paginated books, each_serializer: Api::V1::Serializer::BookSerializer
      end

      def show
        render json: Api::V1::Serializer::BookSerializer.new.serialize_to_json(find_book)
      end

      private

      def find_book
        @find_book ||= Book.find(params[:id])
      end
    end
  end
end
