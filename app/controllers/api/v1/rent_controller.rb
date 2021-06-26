module Api
  module V1
    class RentController < ApiController
      def index
        render_paginated rent_response, each_serializer: rent_serializer
      end

      def create
        new_rent = current_user.rent.new(rent_params)
        if new_rent.save
          render json: rent_serializer.new.serialize_to_json(new_rent), status: :created
        else
          render json: new_rent.errors, status: :bad_request
        end
      end

      def book_ranking
        render json: ranking
      end

      def active
        render json: check_active
      end

      private

      def rent_params
        params.require(:rent).permit(
          :book_id,
          :rent_start,
          :rent_end
        )
      end

      def rent_response
        Rent.where(user_id: params[:user_id])
      end

      def rent_serializer
        Api::V1::Serializer::RentSerializer
      end

      def book
        Book.all
      end

      def ranking
        ranking = []
        book.each do |book|
          ranking << ranking_response(book)
        end
        ranking.sort! { |a, b| b[:times_rented] <=> a[:times_rented] }
      end

      def ranking_response(book)
        { id: book.id,
          author: book.author,
          title: book.title,
          image: { url: book.image },
          publisher: book.editor,
          year: book.year,
          genre: book.gender,
          times_rented: Rent.where(book_id: book.id).count,
          created_at: book.created_at,
          updated_at: book.updated_at }
      end

      def check_active
        actives = []
        Rent.all.each do |book|
          if (book.rent_start <= Date.current - 1) and (book.rent_end >= Date.current - 1)
            actives << book
          end
        end
        actives
      end
    end
  end
end
