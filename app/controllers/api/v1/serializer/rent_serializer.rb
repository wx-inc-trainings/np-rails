module Api
  module V1
    module Serializer
      class RentSerializer < Panko::Serializer
        attributes :id, :returned_at
        aliases rent_start: :from, rent_end: :to

        has_one :book, serializer: Api::V1::Serializer::BookSerializer
        has_one :user, serializer: Api::V1::Serializer::UserSerializer
      end
    end
  end
end
