require 'rails_helper'

RSpec.describe '/api/v1/meta/subjects', type: :request do

  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subjects) { create_list(:subject, 10, s_class_id: s_class_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) { subjects.first.id }


  describe 'GET /api/v1/meta/s_classes/:s_class_id/subjects' do

    before { get "/api/v1/meta/s_classes/#{s_class_id}/subjects"  }

    it 'returns subjects belongs to that  class' do
      expect(json).not_to be_empty 
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'POST /api/v1/meta/s_classes/:s_class_id/subjects' do
    let(:valid_attributes) { { s_name: 'Maths', s_class_id:s_class_id } }

    context 'when the request is valid' do
      before { post "/api/v1/meta/s_classes/#{s_class_id}/subjects", params: valid_attributes }

      it 'creates a subject' do
        expect(json['s_name']).to eq('Maths')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end


  describe 'PUT /api/v1/meta/s_classes/:s_class_id/subjects/:id' do
    let(:valid_attributes) { { s_name: 'Physics',s_class_id:s_class_id } }

    context 'when the record exists' do
      before { put "/api/v1/meta/s_classes/#{s_class_id}/subjects/#{subject_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['s_name']).to eq("Physics")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'DELETE /api/v1/meta/s_classes/:s_class_id/subjects/:id' do
    before { delete "/api/v1/meta/s_classes/#{s_class_id}/subjects/#{subject_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end