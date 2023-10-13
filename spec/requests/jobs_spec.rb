require 'rails_helper'

RSpec.describe "Jobs", type: :request do

  include TokenGenerator
  let(:user) { FactoryBot.create(:user, type: 'Owner') }
  let(:bearer_token) { "Bearer #{token}" }
  let(:token) do
    byebug
    generate_token(user)
  end
  describe "POST /users" do
    it "return success" do
     post '/users', params: { name: "test",user_name: "test@123",email: "test@gmail.com",password: "test123",type: "Customer" }
      expect(response).to have_http_status(:ok) # 200
    end
    it "return not_found params" do
      post '/users', params: {  }
      expect(response).to status(:unprocessable_entity) # 404
    end
    it "return name must exists" do
      post '/users',params: {user_name: "test@123",email: "test@gmail.com",password: "test123",type: "Customer"}
      expect(response).to status(:unprocessable_entity) # 404
    end
  end
  describe "Get /users" do
    subject do
      request.headers["Authorization"] = bearer_token
      get 'index'
    end
    context 'without token' do
      let(:bearer_token) { '' }
      it "return unauthorized" do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq({"error"=>"Nil JSON web token"})
      end
    end
    context 'with token' do
      context 'with valid token' do
        it 'returns all the users' do
          byebug
          expect(subject).to have_http_status(200)
        end
      end
    end
  end










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
      expect(assigns(:jobs)) == job
    end

    # it "renders the index template" do
    #   get '/jobs/index'
    #   expect(response).to render_template("index")
    # end
  end
end
