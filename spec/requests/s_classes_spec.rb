require 'rails_helper'

RSpec.describe '/api/v1/meta/s_classes', type: :request do

  let!(:board) { create(:board) }
  let(:board_id) { board.id }
  let!(:s_classes) { create_list(:s_class, 10, board_id: board_id) }
  let(:s_class_id) { s_classes.first.id }

  describe 'GET /api/v1/meta/boards/:board_id/s_classes' do
    before { get "/api/v1/meta/boards/#{board_id}/s_classes" }

    it 'returns s_classes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/meta/boards/:board_id/s_classes/:s_class_id' do
    before { get "/api/v1/meta/boards/#{board_id}/s_classes/#{s_class_id}" }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(s_class_id)
      end
    end
  end


  describe 'POST /api/v1/meta/boards/:board_id/s_classes' do
    let(:valid_attributes) { { class_no: 9 } }

    context 'when the request is valid' do
      before { post "/api/v1/meta/boards/#{board_id}/s_classes", params: valid_attributes }

      it 'creates a board' do
        expect(json['class_no']).to eq(9)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /api/v1/meta/boards/:board_id/s_classes/:id' do
    let(:valid_attributes) { { class_no: 6 } }

    context 'when the record exists' do
      before { put "/api/v1/meta/boards/#{board_id}/s_classes/#{s_class_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['class_no']).to eq(6)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
  describe 'DELETE /api/v1/meta/boards/:board_id/s_classes/:id' do
    before { delete "/api/v1/meta/boards/#{board_id}/s_classes/#{s_class_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end