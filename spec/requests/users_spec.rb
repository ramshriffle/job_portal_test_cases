require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  user = User.create(user_name: "jaykumar",email:"jay1231@gmail.com",password:"jay123",type:"JobSeeker")

  describe "GET#index" do
    it "assigns @users" do
      get :index
      p user
      expect(assigns(:users)).to eq([user])
    end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end
