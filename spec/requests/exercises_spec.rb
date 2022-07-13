require 'rails_helper'

RSpec.describe '/api/v1/meta/exercises', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject, s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:exercises) { create_list(:exercise, 10, chapter_id: chapter_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:exercise_id) {exercises.first.id}


  
  describe 'GET /api/v1/meta/chapters/:chapter_id/exercises' do
    before { get "/api/v1/meta/chapters/#{chapter_id}/exercises" }

    context 'when chapter exercise exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all chapter exercises' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'GET /api/v1/meta/chapters/:chapter_id/exercises/:exercise_id' do
    before { get "/api/v1/meta/chapters/#{chapter_id}/exercises/#{exercise_id}" }

    context 'when chapter exercise exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(exercise_id)
      end
    end
  end

  describe 'POST /api/v1/meta/chapters/:chapter_id/exercises' do
    let(:valid_attributes) { { title: 'lorem', duration: '10', qn_no:'10',instructions: 'lorem ispum' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/meta/chapters/#{chapter_id}/exercises", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end