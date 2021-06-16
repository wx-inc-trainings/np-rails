RSpec.shared_context 'User Auth' do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  before do
    request.headers.merge!(auth_headers)
  end

  def book_404_response
    book_404_info = File.read('./spec/mock/book_404_info.json')
    JSON.parse book_404_info
  end
end
