RSpec.shared_context 'User Auth' do
  let(:user) { FactoryBot.create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  before do
    request.headers.merge!(auth_headers)
  end
end
