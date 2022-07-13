require 'rails_helper'

RSpec.describe 'api/v1/user_management/student/auth/sessions', type: :request do

    let(:user) { create(:student) } 
  
  describe 'POST /api/v1/user_management/student/auth/signin' do

        let(:valid_credentials) do
            {
                email: user.email,
                password: user.password
            }
        end

        context 'when the request is valid' do
            before { post '/api/v1/user_management/student/auth/signin', params: valid_credentials }

            it 'sign in student' do
                expect(json['status']).to eq('successful')
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the request is invalid' do
            before { post '/api/v1/user_management/student/auth/signin', params: { username: 'Foobar' } }

            it 'doesnt sign in user' do
                expect(json['status']).to eq('failed')
            end

            it 'returns status code 400' do
                expect(response).to have_http_status(400)
            end
        end
  end
end