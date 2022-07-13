require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/exercise_management/attempts', type: :request do

  let!(:user) { create(:student) }
  let!(:valid_headers) { auth_headers(user) }
  let!(:student_enroll) { create(:student_enroll) } 
  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject,s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:exercise) { create(:exercise, chapter_id: chapter_id ) }
  let!(:attempts) { create_list(:attempt, 10, exercise_id: exercise_id, student_enroll_id: student_enroll_id) }
  let(:student_enroll_id) {student_enroll.id}
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:exercise_id) {exercise.id}
  let(:attempt_id) {attempts.last.id}



  describe 'POST /api/v1/user_management/student/exercise_management/attempt_create' do
    let(:valid_attributes) { {  exercise_id:exercise_id } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/exercise_management/attempt_create", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do  
        expect(response).to have_http_status(201)
      end
      it 'checks exercise' do
        expect(json['exercise_id']).to eq(exercise_id) 
      end
    end
  end

  describe 'PUT /api/v1/user_management/student/exercise_management/attempt_end' do
    let(:valid_attributes) { {  exercise_id:exercise_id } }
    context 'when the auth token is valid ' do
      before { put "/api/v1/user_management/student/exercise_management/attempt_end", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'end the attempt' do
        expect(json['finished_at']).not_to be_empty
      end
    end
  end

  describe 'GET /api/v1/user_management/student/exercise_management/:exercise_id/attempts' do
    context 'when the auth token is valid ' do
      before { get "/api/v1/user_management/student/exercise_management/#{exercise_id}/attempts", headers: valid_headers[:auth]}
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns all attempts' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'GET /api/v1/user_management/student/exercise_management/:exercise_id/attempts/:attempt_id' do
    context 'when the auth token is valid ' do
      before { get "/api/v1/user_management/student/exercise_management/#{exercise_id}/attempts/#{attempt_id}", headers: valid_headers[:auth]}
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns single attempt details' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(attempt_id)
      end
    end
  end
 
end