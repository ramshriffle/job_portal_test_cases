require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject {
    FactoryBot.create(:user_profile)
  }
  describe "Associations" do
    it { should belong_to(:user) }
  end
          
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end 

  it "is invalid without first name" do
    subject.l_name = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without last name" do 
   subject.f_name = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without education" do 
    subject.education = nil
     expect(subject).to_not be_valid
   end

   it "is invalid without experience" do 
    subject.experience = nil
     expect(subject).to_not be_valid
   end

   it "is invalid without skills" do 
    subject.skills = nil
     expect(subject).to_not be_valid
   end 
end
