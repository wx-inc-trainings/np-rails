module Api
  module V1
    class RentController < ApiController
      def index
        render json: rent_response
      end

      def create
        new_rent = current_user.rent.new(rent_params)
        if new_rent.save
          render json: rent_serializer.new.serialize_to_json(new_rent), status: :created
        else
          render json: creation_failed, status: :bad_request
        end
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
        rents = Rent.all
        Panko::ArraySerializer.new(rents, each_serializer: rent_serializer).to_json
      end

      def rent_serializer
        Api::V1::Serializer::RentSerializer
      end

      def creation_failed
        { error: 'The rent could not be created' }
      end
    end
  end
end
