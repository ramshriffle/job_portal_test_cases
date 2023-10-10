require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "Associations" do
    it { should belong_to(:user) }
  end

  subject{
    FactoryBot.create(:job)
  }

  it "is valid with valid attributes" do 
    expect(subject).to be_valid
  end

  it "is invalid without description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without location" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without salary" do
    subject.salary = nil
    expect(subject).to_not be_valid
  end
end
