require 'rails_helper'
require 'json'

RSpec.describe Api::V1::OpenLibraryController do
  describe 'GET Correct body response' do
    before do
      stubbed_service = instance_double(OpenLibraryService)
      book_info = File.read('./spec/mock/book_info.json')
      allow(stubbed_service).to receive(:book_info).and_return(JSON.parse(book_info))
      allow(OpenLibraryService).to receive(:new).and_return(stubbed_service)
    end
    describe 'GET body response' do
      it 'Correct body response' do
        book_info = File.read('./spec/mock/book_info.json')
        book_info_service = OpenLibraryService.new('0385472579').book_info
        expect(book_info_service).to eq(JSON.parse(book_info))
      end
    end
  end
end

RSpec.describe Api::V1::OpenLibraryController do
  describe 'GET Bad body response' do
    before do
      stubbed_bad_service = instance_double(OpenLibraryService)
      allow(stubbed_bad_service).to receive(:book_info).and_return({})
      allow(OpenLibraryService).to receive(:new).and_return(stubbed_bad_service)
    end
    describe 'body response' do
      it 'BAD body response' do
        book_info_service = OpenLibraryService.new('bad_isbn').book_info
        expect(book_info_service).to eq({})
      end
    end
  end
end

RSpec.describe 'GET api/v1/open_library/:isbn', type: :request do
  before { get '/api/v1/open_library/0385472579' }
  describe 'Getting a correct response' do
    it 'should be GET code 200' do
      expect(response.status).to eq(200)
    end
    it 'should be GET a correct body response' do
      book_info = File.read('./spec/mock/book_info.json')
      expect(JSON.parse(response.body)).to eq(JSON.parse(book_info))
    end
  end

  describe 'Getting a bad response' do
    before { get '/api/v1/open_library/bad_isbn' }
    it 'should be GET code 404' do
      expect(response.status).to eq(404)
    end
    it 'should be GET error message' do
      book_info = File.read('./spec/mock/book_404_info.json')
      expect(JSON.parse(response.body)).to eq(JSON.parse(book_info))
    end
  end
end
