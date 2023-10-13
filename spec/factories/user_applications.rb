FactoryBot.define do
  factory :user_application do
    status {"applied"}
    user_id {FactoryBot.create(:user,type: 'JobSeeker').id}
    user
    job    
  end
end
