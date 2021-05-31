RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'shared stuff', shared_context: :metadata do
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

RSpec.configure do |rspec|
  rspec.include_context 'shared stuff', include_shared: true
end
