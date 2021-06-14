require 'rails_helper'

RSpec.describe Api::V1::BookController, type: :controller do
  include_context 'User Auth'
  describe 'GET #index' do
    context 'When fetching all books' do
      let!(:book) { create_list(:book, 3) }

      before do
        get :index
      end

      it 'response with books json' do
        resp = JSON.parse(response.body)
        books = []
        book.each do |item|
          books << Api::V1::Serializer::BookSerializer.new.serialize_to_json(item)
        end
        books.each_with_index do |item, index|
          expect(JSON.parse(item)).to eq(resp['page'][index])
        end
      end

      it 'responds with status 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a book' do
      let!(:book) { create(:book) }
      before do
        get :show, params: { id: book.id }
      end

      it 'response with the book json' do
        expected = Api::V1::Serializer::BookSerializer.new.serialize_to_json(book)
        expect(response.body).to eq(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
