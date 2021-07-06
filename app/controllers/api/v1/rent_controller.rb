module Api
  module V1
    class RentController < ApiController
      def index
        @rents = Rent.where(user_id: params[:user_id])
        authorize @rents
        render_paginated @rents, each_serializer: rent_serializer
      end

      def create
        rent = new_rent(params[:user_id])
        authorize rent
        if rent.save
          render json: rent_serializer.new.serialize_to_json(rent), status: :created
        else
          render json: rent.errors, status: :bad_request
        end
      end

      def book_ranking
        @books = Book.rents_ranking
        authorize @books
        render_paginated @books, each_serializer: book_serializer
      end

      def active
        @actives = Rent.rents_order_by_end_date(Date.current)
        authorize @actives
        render_paginated @actives, each_serializer: rent_serializer
      end

      private

      def rent_params
        params.require(:rent).permit(
          :book_id,
          :rent_start,
          :rent_end
        )
      end

      def new_rent(user_id)
        rent = Rent.new(rent_params)
        rent.user_id = user_id
        rent
      end

      def rent_serializer
        Api::V1::Serializer::RentSerializer
      end

      def book_serializer
        Api::V1::Serializer::BookSerializer
      end
    end
  end
end
