require 'json'

RSpec.shared_context 'shared stuff', shared_context: :metadata do
  require 'json'
  def book_correct_info
    book_correct_info = File.read('./spec/mock/book_info.json')
    JSON.parse book_correct_info
  end

  def book_404_info
    book_404_info = File.read('./spec/mock/book_404_info.json')
    JSON.parse book_404_info
  end

  before do
    @stubbed_service = instance_double(OpenLibraryService)
    allow(@stubbed_service).to receive(:book_info).and_return(book_correct_info)
    allow(OpenLibraryService).to receive(:new).and_return(@stubbed_service)
  end
end
