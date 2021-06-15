require 'rails_helper'

RSpec.describe Api::V1::BookController, type: :controller do
  describe action 'GET #index' do
    describe example 'When fetching all books' do
      default_example

      include_context 'User Auth'
      let!(:book) { create_list(:book, 3) }

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
  end
end
