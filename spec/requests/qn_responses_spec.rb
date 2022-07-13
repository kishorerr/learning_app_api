require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/exercise_management/qn_responses', type: :request do

  let!(:user) { create(:student) }
  let!(:valid_headers) { auth_headers(user) }
  let!(:student_enroll) { create(:student_enroll) } 
  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class,board_id: board_id) }
  let!(:subject) { create(:subject,s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:exercise) { create(:exercise, chapter_id: chapter_id ) }
  let!(:attempt) { create(:attempt, exercise_id: exercise_id, student_enroll_id: student_enroll_id) }
  let!(:question) { create(:question, exercise_id: exercise_id ) }
  let!(:option) { create(:option, question_id: question_id) }
  let!(:qn_response) { create(:qn_response, question_id: question_id, attempt_id: attempt_id ) }
  let(:student_enroll_id) {student_enroll.id}
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:exercise_id) {exercise.id}
  let(:attempt_id) {attempt.id}
  let(:question_id) {question.id}
  let(:option_name) {option.option_name}



  describe 'PUT /api/v1/user_management/student/exercise_management/attempt_create' do
    let(:valid_attributes) { {  selected_option: option_name, marked_for_review: "true", exercise_id: exercise_id,question_id: question_id } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/exercise_management/qn_response", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do  
        expect(response).to have_http_status(201)
      end
      it 'checks selected option' do
        expect(json['selected_option']).to eq(option_name) 
      end
    end
  end
 
end