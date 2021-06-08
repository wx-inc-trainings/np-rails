FactoryBot.define do
  factory :book do
    gender { Faker::Book.genre }
    author { Faker::Book.author }
    image { 'image.jpg' }
    title { Faker::Book.title }
    editor { Faker::Book.publisher }
    year { '2021' }
  end
end
