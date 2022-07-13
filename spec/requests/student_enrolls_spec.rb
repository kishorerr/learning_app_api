require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/student_enrolls', type: :request do

  let!(:user) { create(:student) }
  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:valid_headers) { auth_headers(user) }
  let!(:student_enroll) { create(:student_enroll) } 
  let(:s_class_id) { s_class.id}
  let(:board_id) { board.id }
  let!(:student_enroll_id) {student_enroll.id}


  describe 'PUT /api/v1/user_management/student/student_enrolls' do
    let(:valid_attributes) { {  board_id:board_id } }
    context 'when the auth token is invalid' do
      before { put "/api/v1/user_management/student/student_enrolls", params: valid_attributes, as: :json, headers: {'Authorizaton' => "foo"} }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /api/v1/user_management/student/student_enrolls' do
    let(:valid_attributes) { {  board_id:board_id } }
    context 'when the auth token is valid ' do
      before { put "/api/v1/user_management/student/student_enrolls", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
  end

  describe 'PUT /api/v1/user_management/student/student_enrolls' do
    let(:valid_attributes) { {  class_id:s_class_id } }
    context 'when the auth token is valid ' do
      before { put "/api/v1/user_management/student/student_enrolls", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
  end
 
end