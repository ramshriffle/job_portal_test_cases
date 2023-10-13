FactoryBot.define do
  factory :user do
    user_name { Faker::Internet.unique.user_name }
    email { Faker::Internet.unique.email}
    password { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
    password_confirmation { password }
    type { 'JobSeeker' }
    end
end
