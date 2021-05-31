require 'rails_helper'
require_relative '../support/shared_context'

RSpec.describe Api::V1::OpenLibraryController, type: :request do
  describe 'GET book info' do
    describe 'with valid isbn' do
      before { get '/api/v1/open_library/0385472579' }
      include_context 'shared stuff'
      context 'Correct response' do
        it 'Correct status response' do
          expect(response.status).to eq(200)
        end
        it 'Correct body response' do
          expect(JSON.parse(response.body)).to eq(book_correct_info)
        end
      end
    end

    describe 'with bad isbn' do
      before { get '/api/v1/open_library/asdf' }
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
