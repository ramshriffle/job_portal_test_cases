FactoryBot.define do
  factory :user_profile do
    f_name { "ram" }
    l_name { "kumar" }
    education { "B.Tech" }
    experience { "2 year" }
    skills { "java,js,react" }
    user
  end
end
