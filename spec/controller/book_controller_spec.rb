require 'rails_helper'

RSpec.describe Api::V1::BookController, type: :controller do
  describe action 'GET #index' do
    describe example 'Without login' do
      default_example

      include_context 'Dont User Auth'

      before do
        get :index
      end

      it 'message for dont auth' do
        expect(JSON.parse(response.body)).to eq(dont_login)
      end

      it 'status 400' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe example 'When fetching all books' do
      default_example

      include_context 'User Auth'
      let!(:book) { create_list(:book, 3) }
      puts :book
      before do
        get :index
      end

      it 'response is paginated' do
        expect(response_body).to be_paginated
      end

      it 'responds with status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe example 'When fetching a book' do
      default_example

      include_context 'User Auth'
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

    describe example 'book not found' do
      default_example

      include_context 'User Auth'

      before do
        get :show, params: { id: 'bad_id_for_book' }
      end
      it '404 message response' do
        expect(JSON.parse(response.body)).to eq(book_404_response)
      end

      it 'responds with 401 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
