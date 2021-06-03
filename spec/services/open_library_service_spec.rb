require 'rails_helper'

RSpec.describe 'GET to Openlibrary service' do
  describe 'success' do
    include_context 'get request success'
    describe 'with correct query' do
      let(:isbn) { '100' }
      it 'correct response' do
        uri = URI("https://www.openlibrary.org/api/books?bibkeys=#{isbn}&format=json&jscmd=data")
        response = Net::HTTP.get(uri)
        expect(response).to have_requested(:get, 'https://www.openlibrary.org/api/books')
          .with(query: { bibkeys: isbn, format: 'json', jscmd: 'data' })
      end
    end
  end
  describe 'failure' do
    include_context 'get request failure'
    describe 'with bad query' do
      let(:isbn) { 'bad_isbn' }
      it 'a bad body response' do
        uri = URI("https://www.openlibrary.org/api/books?bibkeys=#{isbn}&format=json&jscmd=data")
        response = Net::HTTP.get(uri)
        expect(response).to have_requested(:get, 'https://www.openlibrary.org/api/books')
          .with(query: { bibkeys: isbn, format: 'json', jscmd: 'data' })
      end
    end
  end
end
