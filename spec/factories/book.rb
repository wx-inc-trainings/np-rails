FactoryBot.define do
  title = Faker::Book.title
  if title.length > 25
    title = "#{title.first(22)}..."
  end
  factory :book do
    gender { Faker::Book.genre }
    author { Faker::Book.author }
    image { 'image.jpg' }
    title { title }
    editor { Faker::Book.publisher }
    year { '2021' }
  end
end
