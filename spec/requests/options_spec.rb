require 'rails_helper'

RSpec.describe '/api/v1/meta/options', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject, s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:exercise) { create(:exercise,chapter_id: chapter_id ) }
  let!(:question) { create(:question,exercise_id: exercise_id ) }
  let!(:options) { create_list(:option, 10, question_id: question_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:exercise_id) {exercise.id}
  let(:question_id) {question.id}
  let(:option_id) {options.first.id}


  
  describe 'GET /api/v1/meta/questions/:question_id/options' do
    before { get "/api/v1/meta/questions/#{question_id}/options" }

    context 'when question exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all question options' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'POST /api/v1/meta/questions/:question_id/options' do
    let(:valid_attributes) { {  option_name:'A',option: 'lorem ispum' , opt_status: 'wrong'} }

    context 'when request attributes are valid' do
      before { post "/api/v1/meta/questions/#{question_id}/options", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/meta/questions/:question_id/options/:option_id' do
    let(:valid_attributes) { { opt_status: 'correct' } }

    before { put "/api/v1/meta/questions/#{question_id}/options/#{option_id}", params: valid_attributes }

    context 'when option exists' do
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates the optionr' do
        updated_item = Option.find(option_id)
        expect(updated_item.opt_status).to match(/correct/)
      end
    end
  end
end