require 'rails_helper'
RSpec.describe JobsController, type: :controller do
  include GenerateToken
  
  let(:user) {FactoryBot.create(:user,type:'JobRecruiter')}
  let(:job) {FactoryBot.create(:job, user_id: user.id)}
  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}"}

  describe 'Get /jobs' do
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
        it 'returns all the jobs' do
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
  end


  describe 'Post create' do
    let(:params) { {}}
    subject do
      request.headers["Authorization"] = bearer_token
      post :create, params: params
    end

    context 'with token' do
      context 'with valid parmas' do
        let(:params) { {job_title:job.job_title, description:job.description, location:job.location, salary:job.salary} }
        it 'retrurn created new job' do
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid parmas' do
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

  describe 'Get show' do
    let(:params) { {id: job.id} }
    subject do
      request.headers["Authorization"] = bearer_token
      get :show, params: params 
    end

    context 'with token' do
      context 'with valid token' do
        it 'returns job' do
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

  describe 'Put update' do
    let(:params) { {job_title:'BDE',location:'mumbai', salary:20000, id: job.id} }
    subject do
      request.headers["Authorization"] = bearer_token
      put :update, params: params
    end

    context 'with token' do
      context 'with valid parmas' do
        it 'retrurn updated job' do
          byebug
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid parmas' do
        let(:params) { {job_title:'',location:'', id: job.id} }
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
    let(:params) { {id: job.id}}
    subject do
      request.headers["Authorization"] = bearer_token
      delete :destroy,params: params
    end

    context 'with token' do
      context 'with valid job' do
        it 'job deleted successfully' do
          expect(subject).to have_http_status(200)
          # expect(subject.body).to 
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