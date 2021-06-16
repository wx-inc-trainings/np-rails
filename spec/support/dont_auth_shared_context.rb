require 'json'

RSpec.shared_context 'Dont User Auth' do
  def dont_login
    response = File.read('./spec/mock/book_controller_dont_login.json')
    JSON.parse(response)
  end
end
