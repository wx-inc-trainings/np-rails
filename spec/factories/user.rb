FactoryBot.define do
  factory :user do
    email { 'test@wolox.com.ar' }
    password { '123123123' }
    password_confirmation { '123123123' }
    first_name { 'Test' }
    last_name { 'TestLastName' }
  end
end
