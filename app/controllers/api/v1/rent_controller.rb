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
        render_paginated Book.rents_ranking, each_serializer: book_serializer
      end

      def active
        render_paginated Rent.rents_order_by_end_date(Date.current), each_serializer: rent_serializer
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
      
      def book_serializer
        Api::V1::Serializer::BookSerializer
      end
    end
  end
end
