require 'rails_helper'

RSpec.describe '/api/v1/meta/contents', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject, s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:contents) { create_list(:content, 10, chapter_id: chapter_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:content_id) {contents.first.id}


  
  describe 'GET /api/v1/meta/chapters/:chapter_id/contents' do
    before { get "/api/v1/meta/chapters/#{chapter_id}/contents" }

    context 'when subject exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all subject chapters' do
        expect(json.size).to eq(10)
      end
    end
  end

  describe 'GET /api/v1/meta/chapters/:chapter_id/contents/:content_id' do
    before { get "/api/v1/meta/chapters/#{chapter_id}/contents/#{content_id}" }

    context 'when chapter content  exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(content_id)
      end
    end
  end

  describe 'POST /api/v1/meta/subjects/:subject_id/chapters/:chapter_id/contents' do
    let(:valid_attributes) { { content: 'video', link: 'www.fsfdsf.com' } }

    context 'when request attributes are valid' do
      before { post "/api/v1/meta/chapters/#{chapter_id}/contents", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/meta/chapters/:chapter_id/contents/:content_id' do
    let(:valid_attributes) { { content: 'pdf' } }

    before { put "/api/v1/meta/chapters/#{chapter_id}/contents/#{content_id}", params: valid_attributes }

    context 'when content exists' do
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'updates the content' do
        updated_item = Content.find(content_id)
        expect(updated_item.content).to match(/pdf/)
      end
    end
  end

  describe 'DELETE /api/v1/meta/chapters/:chapter_id/contents/:content_id' do
    before { delete "/api/v1/meta/chapters/#{chapter_id}/contents/#{content_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end