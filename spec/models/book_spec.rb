require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }

  describe 'validates presence' do
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:editor) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:image) }
  end
  describe 'type date' do
    it { is_expected.to validate_numericality_of(:year).only_integer }
    it { is_expected.to allow_value('image.jpeg').for(:image) }
    it { is_expected.to_not allow_value('image').for(:image) }
  end
  describe '#generate_book' do
    context 'when book is created' do
      it 'generate an id' do
        book.save!
        expect(book.id).to be_present
      end
    end
  end
end
