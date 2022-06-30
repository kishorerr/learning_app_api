require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/auth/signup', type: :request do
  
  
  describe 'POST /api/v1/user_management/student/auth/signup' do

    let(:valid_attributes) { { username: 'Foo',ph_no: '74923822',dob: DateTime.now,email: 'foobar@email.com',password: 'bar',password_confirmation: 'bar' } }

    context 'when the request is valid' do
      before { post '/api/v1/user_management/student/auth/signup', params: valid_attributes }

      it 'creates a student' do
        expect(json['username']).to eq('Foo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
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