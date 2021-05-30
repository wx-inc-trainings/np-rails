require 'rails_helper'
require 'json'

RSpec.describe 'GET /api/v1/open_library/:isbn', type: :request do
  describe 'using a correct isbn' do
    before { get '/api/v1/open_library/0385472579' }
    let(:mock_response) do
      book_info_response = File.read('./spec/mock/book_info.json')
      JSON.parse(book_info_response)
    end
    before do
      @stubbed_service = instance_double(OpenLibraryService)
      allow(@stubbed_service).to receive(:book_info).and_return(mock_response)
      allow(OpenLibraryService).to receive(:new).and_return(@stubbed_service)
    end
    context 'Success response' do
      it 'should be return code 200' do
        expect(response.status).to eq(200)
      end
      it 'should be return a correct body' do
        book = @stubbed_service.book_info
        current_book = JSON.parse(response.body)
        expect(current_book).to eq(book)
      end
    end
  end
end

RSpec.describe 'Testing a bad response', type: :request do
  describe 'using a bad isbn' do
    before { get '/api/v1/open_library/some_incorrect_isbn' }
    let(:mock_failure_response) do
      book_info_response = File.read('./spec/mock/book_404_info.json')
      JSON.parse(book_info_response)
    end
    context 'Failure response' do
      it 'should be return code 404' do
        expect(response.status).to eq(404)
      end
      it 'shoul be return a correct failure body' do
        resp = JSON.parse(response.body)
        expect(resp).to eq(mock_failure_response)
      end
    end
  end
end
