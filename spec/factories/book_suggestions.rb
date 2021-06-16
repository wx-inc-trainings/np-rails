FactoryBot.define do
  factory :book_suggestion do
    synopsis { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    price { Faker::Number.decimal(l_digits: 2) }
    author { Faker::Book.author }
    title { Faker::Book.title }
    link { Faker::Internet.url }
    editor { Faker::Book.publisher }
    year { Faker::Number.number(digits: 4) }
    user_id { Faker::Number.number(digits: 1) }
  end
end
