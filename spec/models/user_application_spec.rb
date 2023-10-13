require 'rails_helper'

RSpec.describe UserApplication, type: :model do 
  subject{
    FactoryBot.create(:user_application)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end 

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:job) }
  end

  # it { should validate_uniqueness_of(:job_id).scoped_to(:user_id) }
end
