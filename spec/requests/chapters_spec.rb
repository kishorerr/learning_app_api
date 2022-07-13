require 'rails_helper'

RSpec.describe '/api/v1/meta/chapters', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject, s_class_id: s_class_id) }
  let!(:chapters) { create_list(:chapter, 10, subject_id:subject_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapters.first.id }

  
  describe 'GET /api/v1/meta/subjects/:subject_id/chapters' do
    before { get "/api/v1/meta/subjects/#{subject_id}/chapters" }

    context 'when subject exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all subject chapters' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'GET /api/v1/meta/subjects/:subject_id/chapters/:id' do
    before { get "/api/v1/meta/subjects/#{subject_id}/chapters/#{chapter_id}" }

    context 'when subject chapter exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(chapter_id)
      end
    end
  end

  describe 'POST /api/v1/meta/subjects/:subject_id/chapters' do
    let(:valid_attributes) { { c_name: 'Trigonometry', pdf_no: '20', video_no: '6' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/meta/subjects/#{subject_id}/chapters", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/meta/subjects/:subject_id/chapters/:id' do
    let(:valid_attributes) { { c_name: 'Number System' } }

    before { put "/api/v1/meta/subjects/#{subject_id}/chapters/#{chapter_id}", params: valid_attributes }

    context 'when chapter exists' do
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates the chapter' do
        updated_item = Chapter.find(chapter_id)
        expect(updated_item.c_name).to match(/Number System/)
      end
    end
  end

  describe 'DELETE /api/meta/subjects/:subject_id/chapters/:id' do
    before { delete "/api/v1/meta/subjects/#{subject_id}/chapters/#{chapter_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end