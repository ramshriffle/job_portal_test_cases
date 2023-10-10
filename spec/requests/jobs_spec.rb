require 'rails_helper'

RSpec.describe "Jobs", type: :request do

  # let!(:user) do
  #   User.create!(
  #     user_name: "jaysingh",
  #     email:"jay321@gmail.com",
  #     password:"jay123",
  #     type:"JobSeeker"
  #   )
  # end

  # let!(:job) do
  #   Job.create!(
  #     job_title: 'hr',
  #     description: 'only for fresher',
  #     salary: '15000',
  #     location: 'indore',
  #     user_id: user.id
  #   )
  # end

  describe "GET index" do
    it "assigns @jobs" do
      job = Job.create
      get '/jobs/index'
      expect(assigns(:jobs))==job
    end
  end
end
