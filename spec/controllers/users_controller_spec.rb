require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include GenerateToken
  let(:user) { FactoryBot.build(:user) }
  let(:token) do 
    user.save
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}" }
  
  describe "Get index" do
    subject do
      request.headers["Authorization"] = bearer_token
      get 'index'
    end
    
    context 'without token' do
      let(:bearer_token) { '' }
      it "return unauthorized" do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq({"error"=>"Invalid token"})
      end
    end
    context 'with token' do
      context 'with valid token' do
        it 'returns all the users' do
          expect(subject).to have_http_status(200)
        end
      end
      
      context 'with invalid token' do
        let(:bearer_token) { 'dh92' }
        it 'return unauthorized' do
          debugger
          expect(subject).to have_http_status(401)
        end
      end
    end
  end
  
  describe 'POST create' do
    let(:params) {{user_name: user.user_name,email: user.email,password:user.password,type:user.type }}
    subject do
      post :create, params: params
    end
    
    context 'create user' do
      context 'with valid params' do
        it 'create new user' do
          # byebug
          expect(subject).to have_http_status(201)
        end
      end
      context 'with invalid params' do
        let(:params) { {} }
        it 'returns not_found' do
          # debugger
          expect(subject).to have_http_status(422)
        end
      end
    end
  end
  
  describe 'PUT update' do
    let(:params) { {}}
    subject do
      request.headers["Authorization"] = bearer_token
      put :update, params: params
    end
    
    context 'with token' do
      context ' valid token' do
        context 'valid params' do
          let(:params) { {user_name: 'its_ram',email: 'ramkush@gmail.com',id: user.id  }}
          it 'returns updated the users' do
            byebug
            expect(subject).to have_http_status(200)
          end
        end
        
        context 'invalid params' do
          let(:params) {{id: user.id, user_name:'', email:'' }}
          it 'unprocessable entity' do
            expect(subject).to have_http_status(422)
          end
        end
      end

      # context 'invalid token' do
      #   it 'return unauthorized' do
      #   end
      # end
    end
    
    # context 'without token' do
    #   let(:bearer_token) { {} }
    #   it "return unauthorized" do
    #     debugger
    #     expect(response).to have_http_status(401)
    #   end
    # end
  end

  describe 'Delete destroy' do 
    let(:params) { {id: user.id}}
    subject do
      request.headers["Authorization"] = bearer_token
      delete :destroy,params: params
    end

    context 'with token' do
      context 'with valid job' do
        it 'user deleted successfully' do
          byebug
          expect(subject).to have_http_status(200)
          # expect(subject.body).to 
        end
      end
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'unauthorized' do
        user.save
        byebug
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq("error"=>"Invalid token")
      end
    end
  end
  
  describe "GET show " do
    let(:params) {{id: user.id}}
    subject do
      request.headers["Authorization"] = bearer_token
      get :show,params: params
    end
  
    context 'with token' do
      context 'with valid token' do
        it 'returns user' do
          byebug
          expect(subject).to have_http_status(200)
        end
      end
      
      context 'with invalid token' do
        let(:bearer_token) { 'dh92' }
        it 'return unauthorized' do
          user.save
          byebug
          expect(subject).to have_http_status(401)
        end
      end
    end
  end 
end


