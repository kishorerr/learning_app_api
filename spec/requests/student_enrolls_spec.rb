require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/student_enrolls', type: :request do


  describe 'PUT /api/v1/user_management/student/student_enrolls' do
    let(:valid_attributes) { { board_id: '1' } }

    context 'when the auth token in invalid or user isnt logged in' do
      before { put "/api/v1/user_management/student/student_enrolls", params: valid_attributes,headers: {'Authorizaton' => "foo"} }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /api/v1/user_management/student/student_enrolls' do
    let(:valid_attributes) { { class_id: '1' } }

    context 'when the auth token in invalid or user isnt logged in' do
      before { put "/api/v1/user_management/student/student_enrolls", params: valid_attributes,headers: {'Authorizaton' => "foo"}  }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
 
end