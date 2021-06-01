require 'rails_helper'
require_relative '../support/shared_context'
require 'json'

RSpec.describe Api::V1::OpenLibraryController, type: :controller do
  describe action 'GET book info #show' do
    before do
      get :show, params: { isbn: isbn }
    end
    describe example 'with valid isbn' do
      let(:isbn) { 100 }
      default_example
      include_context 'shared stuff'
      it 'Correct status response' do
        expect(response.status).to eq(200)
      end
      it 'Correct body response' do
        expect(JSON.parse(response.body)).to eq(book_correct_info)
      end
    end

    describe example 'with bad isbn' do
      let(:isbn) { 'bad_isbn' }
      default_example
      include_context 'shared stuff'
      it 'HTTP status not found' do
        expect(response.status).to eq(404)
      end
      it 'BAD body response' do
        expect(JSON.parse(response.body)).to eq(book_404_info)
      end
    end
  end
end
