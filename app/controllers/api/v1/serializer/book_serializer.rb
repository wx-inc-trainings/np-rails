module Api
  module V1
    module Serializer
      class BookSerializer < Panko::Serializer
        attributes :id, :author, :title, :image, :times_rented, :year, :created_at, :updated_at
        aliases gender: :genre, editor: :publisher
        def image
          {
            url: object.image
          }
        end
        
        def times_rented
          object.rent.count
        end
      end
    end
  end
end
