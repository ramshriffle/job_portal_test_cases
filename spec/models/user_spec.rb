require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  subject {
    FactoryBot.create(:user)
  }
          
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end 
  
  it "is invalid without a user_name" do
   subject.user_name = nil
   expect(subject).to_not be_valid
  end

  it "is invalid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
   end
  
  it "is invalid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  
  it "is invalid without a type" do 
    subject.type = nil
    expect(subject).to_not be_valid
  end
end
