require 'rails_helper'

RSpec.describe BookSuggestion, type: :model do
  subject(:book_suggestion) { build(:book_suggestion) }
  describe 'validates presence' do
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_presence_of(:editor) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:user_id) }
  end
end
