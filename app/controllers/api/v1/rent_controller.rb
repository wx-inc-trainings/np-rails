module Api
  module V1
    class RentController < ApiController
      def index
        @rents = Rent.where(user_id: params[:user_id])
        authorize @rents
        render_paginated @rents, each_serializer: rent_serializer
      end

      def create
        new_rent = Rent.new(rent_params)
        new_rent.user_id = params[:user_id]
        authorize new_rent
        if new_rent.save
          RentMailer.with(rent: new_rent).rent_email.deliver_now
          render json: rent_serializer.new.serialize_to_json(new_rent), status: :created
        else
          render json: new_rent.errors, status: :bad_request
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

      def rent_serializer
        Api::V1::Serializer::RentSerializer
      end

      def book_serializer
        Api::V1::Serializer::BookSerializer
      end
    end
  end
end
