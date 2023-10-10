FactoryBot.define do
  factory :user do
    user_name { "ramkumar" }
    type { "JobRecruiter" }
    email { "test@example.com" }
    password { "012345" }
  end
end
