module Api
  module V1
    module Serializer
      class BookSerializer < Panko::Serializer
        attributes :id, :author, :title, :image, :year, :created_at, :updated_at
        aliases gender: :genre, editor: :publisher
        def image
          {
            url: object.image
          }
        end
      end
    end
  end
end
