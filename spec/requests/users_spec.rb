require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Post create" do
    subject do 
      post '/users/create',params: :params
    end 
    let(:params) {{}}
    context "with valid params" do
      let(:params) { {user_name: 'anuj',email: 'anuj123@gmail.com',password: 'anuj123',type: 'JobSeeker'}}
      it "create new user" do
        expect(subject).to have_http_status(:success)
      end
    end 
  end
end
