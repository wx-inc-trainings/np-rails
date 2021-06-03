RSpec.shared_context 'get request success', shared_context: :metadata do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:get, 'https://www.openlibrary.org/api/books?bibkeys=100&format=json&jscmd=data')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/get_response_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
RSpec.shared_context 'get request failure', shared_context: :metadata do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:get, 'https://www.openlibrary.org/api/books?bibkeys=bad_isbn&format=json&jscmd=data')
      .to_return(
        status: 404,
        body: File.read('./spec/support/fixtures/get_response_failure.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
