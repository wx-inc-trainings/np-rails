FactoryBot.define do
  password = Faker::Alphanumeric.alpha(number: 10)
  factory :user do
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    first_name { Faker::Games::LeagueOfLegends.champion }
    last_name { Faker::Games::LeagueOfLegends.location }
  end
end
