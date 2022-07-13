require 'rails_helper'

RSpec.describe 'api/v1/user_management/student/auth/registrations', type: :request do
  
  
  describe 'POST /api/v1/user_management/student/auth/signup' do

    let(:valid_attributes) { {username: 'Foo',ph_no: '74923822',dob: '2001-07-08',email: 'foo@email.com',password: 'barcode',password_confirmation: 'barcode' } }

    context 'when the request is valid' do
      before { post '/api/v1/user_management/student/auth/signup', params: valid_attributes }

      it 'creates a student' do
        expect(json['email']).to eq('foo@email.com')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/user_management/student/auth/signup', params: { username: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end