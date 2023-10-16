require 'rails_helper'

RSpec.describe UserProfilesController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user)}
  let(:user_profile) { FactoryBot.create(:user_profile, user_id: user.id)}
  let(:token) do
    generate_token(user)
  end  
  let(:bearer_token) { "Bearer #{token}"}

  describe 'Get show' do
    let(:params) { {id: user_profile.id} }
    subject do
      request.headers["Authorization"] = bearer_token
      get :show, params: params
    end

    context 'with token' do
      context 'with valid token' do
        it 'returns profile of user' do
          # user_profile.save
          expect(subject).to have_http_status(200)
        end
      end
      
      context 'with invalid token' do
        let(:bearer_token) { 'dh92' }
        it 'return unauthorized' do
          expect(subject).to have_http_status(401)
        end
      end
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it "return unauthorized" do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq({"error"=>"Invalid token"})
      end
    end
  end

  describe 'Post create' do
    let(:params) { {} }
    subject do
      request.headers["Authorization"] = bearer_token
      post :create, params: params
    end

    context 'with token' do
      context 'with valid parmas' do
        let(:params) { {f_name:user_profile.f_name, l_name:user_profile.l_name, education:user_profile.education, experience:user_profile.experience, skills: user_profile.skills} }
        it 'retrurn user profile' do
          byebug
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid parmas' do
        it 'return unprocessable entity ' do
          byebug
          expect(subject).to have_http_status(422)
        end
      end
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'unauthorized' do
        byebug
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq("error"=>"Invalid token")
      end
    end
  end

  describe 'Put update' do
    let(:params) { {f_name:'Ram',l_name:'Kushwah', experience:'4 year',id: user_profile.id} }
    subject do
      request.headers["Authorization"] = bearer_token
      put :update, params: params
    end

    context 'with token' do
      context 'with valid parmas' do
        it 'retrurn updated profile' do
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid parmas' do
        let(:params) { {f_name:'',l_name:'', experience:'',id: user_profile.id} }
        it 'return unprocessable entity ' do
          expect(subject).to have_http_status(422)
        end
      end
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'unauthorized' do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq("error"=>"Invalid token")
      end
    end
  end

  describe 'Delete destroy' do
    let(:params) { {id: user_profile.id} }
    subject do
      request.headers["Authorization"] = bearer_token
      delete :destroy, params:params
    end

    context 'with token' do
      context 'with valid user' do
        it 'profile deleted successfully' do
          expect(subject).to have_http_status(200)
          # expect(user_profile).to be_empty()
        end
      end
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'unauthorized' do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq("error"=>"Invalid token")
      end
    end
  end
end