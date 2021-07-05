module Api
  module V1
    module Serializer
      class UserSerializer < Panko::Serializer
        attributes :id, :first_name, :last_name, :email, :rents_counter
        aliases image: :image_url

        def rents_counter
          object.rent.count
        end
      end
    end
  end
end
