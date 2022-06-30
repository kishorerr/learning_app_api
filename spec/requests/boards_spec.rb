require 'rails_helper'

RSpec.describe '/api/v1/boards', type: :request do
  # initialize test data
  let!(:boards) { create_list(:board, 10) }
  let(:board_id) { boards.first.id }

  # Test suite for GET /todos
  describe 'GET /api/v1/boards' do
    # make HTTP get request before each example
    before { get '/api/v1/boards' }

    it 'returns boards' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /todos
  describe 'POST /api/v1/boards' do
    # valid payload
    let(:valid_attributes) { { b_name: 'ICSE', b_desc: 'Lorem Ipsum' } }

    context 'when the request is valid' do
      before { post '/api/v1/boards', params: valid_attributes }

      it 'creates a board' do
        expect(json['b_name']).to eq('ICSE')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/boards', params: { b_name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /api/v1/boards/:id' do
    let(:valid_attributes) { { b_name: 'CBSE' } }

    context 'when the record exists' do
      before { put "/api/v1/boards/#{board_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /api/v1/boards/:id' do
    before { delete "/api/v1/boards/#{board_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end