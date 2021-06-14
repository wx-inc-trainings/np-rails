RSpec.shared_context 'User Auth' do
  let(:user) { User.create(email: 'test@wolox.com.ar', password: '123123123', password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName') }

  before do
    request.headers.merge! user.create_new_auth_token
  end
end