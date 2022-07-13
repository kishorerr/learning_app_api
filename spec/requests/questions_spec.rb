require 'rails_helper'

RSpec.describe '/api/v1/meta/questions', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject, s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:exercise) { create(:exercise,chapter_id: chapter_id ) }
  let!(:questions) { create_list(:question, 10, exercise_id: exercise_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:exercise_id) {exercise.id}
  let(:question_id) {questions.first.id}


  
  describe 'GET /api/v1/meta/exercises/:exercise_id/questions' do
    before { get "/api/v1/meta/exercises/#{exercise_id}/questions" }

    context 'when subject exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all subject chapters' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'POST /api/v1/meta/exercises/:exercise_id/questions' do
    let(:valid_attributes) { {  qn_no:'10', question: 'lorem ispum' , duration: DateTime.now, solution: 'foobar'} }

    context 'when request attributes are valid' do
      before { post "/api/v1/meta/exercises/#{exercise_id}/questions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/meta/exercises/:exercise_id/questions/:question_id' do
    let(:valid_attributes) { { question: 'hello world' } }

    before { put "/api/v1/meta/exercises/#{exercise_id}/questions/#{question_id}", params: valid_attributes }

    context 'when chapter exists' do
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates the chapter' do
        updated_item = Question.find(question_id)
        expect(updated_item.question).to match(/hello world/)
      end
    end
  end
end