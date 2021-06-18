require 'rails_helper'
RSpec.describe Api::V1::BookSuggestionController, type: :controller do
  describe action 'Create BookSuggestion #create' do
    let!(:suggestion) { build(:book_suggestion) }
    describe example 'Creating a valid BookSuggestion' do
      default_example

      let(:attributes) do
        {
          synopsis: suggestion.synopsis,
          price: suggestion.price,
          author: suggestion.author,
          title: suggestion.title,
          link: suggestion.link,
          editor: suggestion.editor,
          year: suggestion.year,
          user_id: nil
        }
      end
      it 'Creates a new Suggestion' do
        expect do
          post :create, params: { book_suggestion: attributes }
        end.to change { BookSuggestion.count }.by(1)
      end
      it 'responds with 201 status' do
        post :create, params: { book_suggestion: attributes }
        expect(response).to have_http_status(:created)
      end
    end

    describe example 'Creating an invalid BookSuggestion' do
      default_example

      # the required attributes are not being placed
      let(:attributes) do
        {
          synopsis: suggestion.synopsis,
          price: suggestion.price,
          user_id: nil
        }
      end
      it 'creates booksuggestion with invalid attributes' do
        expect do
          post :create, params: { book_suggestion: attributes }
        end.to change { BookSuggestion.count }.by(0)
      end

      it 'response 400 status' do
        post :create, params: { book_suggestion: attributes }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
