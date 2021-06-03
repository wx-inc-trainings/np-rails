module Api
  module V1
    class OpenLibraryController < ApplicationController
      include Wor::Paginate
      def index
        book_info = OpenLibraryService.new('100').book_info
        render_paginated book_info
      end

      def show
        book_info = OpenLibraryService.new(params[:isbn]).book_info
        render json: book_info[:response], status: book_info[:status]
      end
    end
  end
end
