require 'rails_helper'

RSpec.describe Api::V1::BookController, type: :request do
  include_context 'User Auth'
  describe "GET #index" do
    before do
      get :index
    end
    it "a context" do
      puts response_body
    end
  end
end