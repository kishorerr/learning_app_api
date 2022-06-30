require 'rails_helper'

RSpec.describe '/api/v1/s_classes', type: :request do

  let!(:s_classes) { create_list(:s_class, 10) }
  let(:s_class_id) { s_classes.first.id }

  describe 'GET /api/v1/s_classes' do
    before { get '/api/v1/s_classes' }

    it 'returns s_classes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'POST /api/v1/s_classes' do
    let(:valid_attributes) { { class_no: '10' } }

    context 'when the request is valid' do
      before { post '/api/v1/s_classes', params: valid_attributes }

      it 'creates a board' do
        expect(json['class_no']).to eq(10)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/s_classes', params: { } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/s_classes/:id' do
    let(:valid_attributes) { { class: '10' } }

    context 'when the record exists' do
      before { put "/api/v1/s_classes/#{s_class_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  describe 'DELETE /api/v1/s_classes/:id' do
    before { delete "/api/v1/s_classes/#{s_class_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end